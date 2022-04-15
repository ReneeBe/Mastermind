//
//  GuessBox.swift
//  LinkedInApp
//
//  Created by Renee Berger on 4/13/22.
//

import SwiftUI

struct GuessBox: View {
  var viewModel: ViewModel
  var model: Model
  var row: Int
  var column: Int
  let screenSize: CGRect
  @State var guessValue: String = ""

  init(viewModel: ViewModel, model: Model, row: Int, column: Int, screenSize: CGRect) {
    self.viewModel = viewModel
    self.model = model
    self.row = row
    self.column = column
    self.screenSize = screenSize
    let value = self.viewModel.getValue(row: row, column: column)
    if value != nil {
      guessValue = String(value!)
    } else {
      guessValue = ""
    }
  }

  var body: some View {
    RoundedRectangle(cornerRadius: 20, style: .continuous)
      .foregroundColor(.gray.opacity(0.5))
      .frame(width: screenSize.width / 7.3, height: screenSize.width / 7.3)
      .overlay(
        TextField("_", text: $guessValue)
          .keyboardType(.decimalPad)
          .accentColor(.primary)
          .padding()
      )
      .onChange(of: guessValue) { newValue in
        let num = Int(newValue)
        let numAsGuess = num != nil ? Game.Guess.guess(num!) : .empty
        model.changeGuess(row: row, col: column, guess: numAsGuess)
      }
      .disabled(viewModel.rowState(row: row) != .active || viewModel.gameState() != .inProgress)
      .onChange(of: self.viewModel) { newValue in
        let value = newValue.getValue(row: row, column: column)
        if value != nil {
          if String(value!) != guessValue {
            guessValue = String(value!)
          }
        } else {
          if "" != guessValue {
            guessValue = ""
          }
        }
      }
  }
}

struct GuessBox_Previews: PreviewProvider {
  static var previews: some View {
    let model = Model()
    let size = UIScreen.main.bounds
    GuessBox(viewModel: model.viewModel, model: model, row: 1, column: 1, screenSize: size)
  }
}
