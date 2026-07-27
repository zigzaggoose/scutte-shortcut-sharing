//
//  shortcut_hubApp.swift
//  shortcut hub
//
//  Created by Rishab Reji on 31/12/2025.
//

import SwiftUI

@main
struct shortcut_hubApp: App {
    @State private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoggedIn {
                ContentView()
                    .environment(authViewModel)
            } else {
                AuthView()
                    .environment(authViewModel)
            }
        }
    }
}
