//
//  LinkedInAppApp.swift
//  LinkedInApp
//
//  Created by Renee Berger on 4/6/22.
//

import SwiftUI

@main
struct LinkedInAppApp: App {
  @StateObject var model: Model = Model()

  var body: some Scene {
    WindowGroup {
      ContentView(viewModel: self.model.viewModel, model: model)
        .onAppear {
          Task {
            try await self.model.getNewGame()
          }
        }
    }
  }
}
