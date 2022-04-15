//
//  Model.swift
//  LinkedInApp
//
//  Created by Renee Berger on 4/12/22.
//

import Foundation

@MainActor class Model: ObservableObject {
  @Published var viewModel: ViewModel
  private var gameData: Game
  var password: [Int] = []

  init() {
    self.gameData = Game(password: [0, 1, 2, 3])
    viewModel = ViewModel(gameData: gameData, ready: false)
  }

  func changeGuess(row: Int, col: Int, guess: Game.Guess) {
    self.gameData.guesses[row].guesses[col] = guess
    viewModel = ViewModel(gameData: gameData, ready: viewModel.ready)
  }

  func submitRow(row: Int) {
    self.gameData.guesses[row].submitted = true
    viewModel = ViewModel(gameData: gameData, ready: viewModel.ready)
  }

  func fetchPassword() async throws {
    let secretURL = URL(
      string:
        "https://www.random.org/integers/?num=4&min=0&max=7&col=1&base=10&format=plain&rnd=new")!
    let (data, _) = try await URLSession.shared.data(for: URLRequest(url: secretURL))
    let result = String(data: data, encoding: .utf8)!
      .components(separatedBy: "\n")
    var temp: [Int] = []
    result.forEach { num in
      if (Int(num)) != nil {
        temp.append(Int(num)!)
      }
    }
    password = temp
  }

  func getNewGame() async throws {
    Task {
      try! await fetchPassword()
      gameData = Game(password: password)
      viewModel = ViewModel(gameData: gameData, ready: true)
    }
  }
}

struct Game: Equatable {
  enum Guess: Equatable {
    case empty
    case guess(Int)
  }

  struct Row: Equatable {
    var guesses = Array(repeating: Guess.empty, count: 4)
    var submitted = false
  }

  var password: [Int]
  var guesses: [Row]
  let totalGuesses: Int = 10

  init(password: [Int], guesses: [Row] = Array(repeating: Row(), count: 10)) {
    self.password = password
    self.guesses = guesses
  }
}

extension Game {
  static let previewData: Game = Game(password: [1, 2, 3, 4], guesses: [Row()])
}
