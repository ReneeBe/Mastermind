//
//  ContentView.swift
//  LinkedInApp
//
//  Created by Renee Berger on 4/6/22.
//

import Foundation
import SwiftUI

struct ContentView: View {
  var viewModel: ViewModel
  var model: Model
  let screenSize: CGRect = UIScreen.main.bounds
  @State private var gameOver: Bool = false

  var body: some View {
    ScrollView {
      VStack {
        if gameOver == true {
          Text(viewModel.gameState() == .win ? "You Won!" : "Wanna Play Again?").bold()
            .foregroundColor(.blue)
            .font(.title)
          Button(
            action: {
              Task {
                try? await model.getNewGame()
                gameOver = false
              }
            },
            label: {
              Text("New Game")
            }
          )
          .buttonStyle(.borderedProminent)
        } else {
          Header(model: model)
        }

        ForEach(0..<viewModel.gameData.totalGuesses, id: \.self) { index in
          GuessRow(viewModel: viewModel, model: model, index: index, screenSize: screenSize)
        }

        .onChange(of: viewModel) { newValue in
          let state = newValue.gameState()
          if state != .inProgress {
            gameOver = true
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let model = Model()
    ContentView(viewModel: model.viewModel, model: model)
  }
}
