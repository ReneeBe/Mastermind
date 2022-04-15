//
//  GuessRow.swift
//  LinkedInApp
//
//  Created by Renee Berger on 4/14/22.
//

import SwiftUI

struct GuessRow: View {
  var viewModel: ViewModel
  var model: Model
  var index: Int
  let screenSize: CGRect

  var body: some View {
    HStack(alignment: .center) {
      GuessBox(viewModel: viewModel, model: model, row: index, column: 0, screenSize: screenSize)
      GuessBox(viewModel: viewModel, model: model, row: index, column: 1, screenSize: screenSize)
      GuessBox(viewModel: viewModel, model: model, row: index, column: 2, screenSize: screenSize)
      GuessBox(viewModel: viewModel, model: model, row: index, column: 3, screenSize: screenSize)
      if viewModel.rowState(row: index) != .submittable {
        AnswerBox(rowEvaluation: viewModel.rowEvaluation(row: index))
          .frame(width: screenSize.width / 3.65, height: screenSize.width / 7.3)
      } else if viewModel.rowState(row: index) == .submittable {
        Button(
          action: {
            model.submitRow(row: index)
          },
          label: {
            Image(systemName: "checkmark")
          }
        )
        .frame(width: screenSize.width / 3.65, height: screenSize.width / 7.3)
        .disabled(viewModel.rowState(row: index) != .submittable)
      }
    }
  }
}

struct GuessRow_Previews: PreviewProvider {
  static var previews: some View {
    let model = Model()
    let size = UIScreen.main.bounds
    GuessRow(viewModel: model.viewModel, model: model, index: 0, screenSize: size)
  }
}
