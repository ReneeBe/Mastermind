//
//  Header.swift
//  LinkedInApp
//
//  Created by Renee Berger on 4/13/22.
//

import SwiftUI

struct Header: View {
  var model: Model

  var body: some View {
    VStack {
      HStack {
        Image(systemName: "gearshape.fill")
          .foregroundColor(.clear)
        Spacer()
        Text("Mastermind").bold()
          .foregroundColor(.blue)
          .font(.title)
        Spacer()
        Button(
          action: {
            Task {
              try? await model.getNewGame()
            }
          },
          label: {
            Image(systemName: "plus.circle")
          })
      }
      .padding(.horizontal)
    }
  }
}

struct Header_Previews: PreviewProvider {

  static var previews: some View {
    Header(model: Model())
  }
}
