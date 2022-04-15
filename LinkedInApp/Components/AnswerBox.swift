//
//  AnswerBox.swift
//  LinkedInApp
//
//  Created by Renee Berger on 4/14/22.
//

import SwiftUI

struct AnswerBox: View {
  var rowEvaluation: ViewModel.RowEvaluation

  var body: some View {
    RoundedRectangle(cornerRadius: 20, style: .continuous)
      .overlay(
        HStack {
          Image(systemName: "circle.fill")
            .foregroundColor(self.colorFromScore(placeScore: rowEvaluation.placeScores[0]))
          Image(systemName: "circle.fill")
            .foregroundColor(self.colorFromScore(placeScore: rowEvaluation.placeScores[1]))
          Image(systemName: "circle.fill")
            .foregroundColor(self.colorFromScore(placeScore: rowEvaluation.placeScores[2]))
          Image(systemName: "circle.fill")
            .foregroundColor(self.colorFromScore(placeScore: rowEvaluation.placeScores[3]))
        }
      )
      .font(.caption)
  }

  func colorFromScore(placeScore: ViewModel.PlaceScore) -> Color {
    switch placeScore {
    case .unevaluated:
      return .white
    case .incorrect:
      return .red
    case .wrongLocation:
      return .yellow
    case .rightLocation:
      return .green
    }
  }
}

struct AnswerBox_Previews: PreviewProvider {
  static var previews: some View {
    AnswerBox(rowEvaluation: ViewModel.RowEvaluation())
  }
}
