//
//  ViewModel.swift
//  LinkedInApp
//
//  Created by Renee Berger on 4/13/22.
//

import Foundation

class ViewModel: ObservableObject, Equatable {
  static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
    lhs.gameData == rhs.gameData
  }

  var gameData: Game
  let ready: Bool

  init(gameData: Game, ready: Bool) {
    self.gameData = gameData
    self.ready = ready
  }

  enum RowState: Equatable {
    case inactive
    case active
    case submittable
    case submitted
  }

  func rowState(row: Int) -> RowState {
    let rowData = self.gameData.guesses[row]
    if row == 0 {
      let rowIsFull = !rowData.guesses.contains(where: { guess in
        guess == .empty
      })

      return rowData.submitted ? .submitted : rowIsFull ? .submittable : .active
    }

    if rowData.submitted {
      return .submitted
    }

    let preceedingRow = self.gameData.guesses[row - 1]

    if !preceedingRow.submitted {
      return .inactive
    }

    let rowIsFull = !rowData.guesses.contains(where: { guess in
      guess == .empty
    })

    return rowIsFull ? .submittable : .active
  }

  enum PlaceScore: Equatable, Comparable {
    case unevaluated
    case incorrect
    case wrongLocation
    case rightLocation
  }

  struct RowEvaluation {
    var winning = false
    var placeScores = Array(repeating: PlaceScore.unevaluated, count: 4)
  }

  func rowEvaluation(row: Int) -> RowEvaluation {
    var eval = RowEvaluation()
    var passwordCopy = self.gameData.password
    let currRow = self.gameData.guesses[row].guesses
    var correctCount = 0
    //first pass to confirm correct location and value
    for index in 0..<4 {
      switch currRow[index] {
      case .empty:
        return RowEvaluation()
      case .guess(let guess):
        if guess == passwordCopy[index] {
          eval.placeScores[index] = PlaceScore.rightLocation
          passwordCopy.replaceSubrange(index...index, with: [-1])
        }
      }
    }

    for index in 0..<4 {
      if eval.placeScores[index] == PlaceScore.unevaluated {
        switch currRow[index] {
        case .empty:
          return RowEvaluation()
        case .guess(let guess):
          if passwordCopy.contains(guess) {
            eval.placeScores[index] = PlaceScore.wrongLocation
          } else {
            eval.placeScores[index] = PlaceScore.incorrect
          }
        }
      } else {
        correctCount += 1
      }
    }

    if correctCount == 4 {
      eval.winning = true
    } else {
      eval.placeScores.sort()
    }
    return eval
  }

  enum GameState {
    case win
    case lose
    case inProgress
  }

  func gameState() -> GameState {
    let guesses = self.gameData.guesses
    // call row state on each row and figure out if all rows are submitted
    // call rowEvaluation and find out if there is a winner

    let winners = guesses.indices.filter { index in
      let eval = rowEvaluation(row: index)
      return eval.winning
    }

    if winners.count > 0 {
      return .win
    }

    let unsubmitted = guesses.indices.filter { index in
      let state = rowState(row: index)
      return state != .submitted
    }

    if unsubmitted.count > 0 {
      return .inProgress
    }

    return .lose
  }

  func getValue(row: Int, column: Int) -> Int? {
    switch self.gameData.guesses[row].guesses[column] {
    case .empty:
      return nil
    case .guess(let value):
      return value
    }
  }
}
