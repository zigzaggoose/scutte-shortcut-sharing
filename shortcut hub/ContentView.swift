//
//  ContentView.swift
//  shortcut hub
//
//  Created by Rishab Reji on 31/12/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("appColorScheme") private var appColorScheme = 0

    private var colorSchemeValue: ColorScheme? {
        switch appColorScheme {
        case 1: return .light
        case 2: return .dark
        default: return nil
        }
    }

    var body: some View {
        TabView {
            Tab("Home", systemImage: Constants.homeIconString) {
                HomeView()
            }
            Tab("Search", systemImage: Constants.searchIconString) {
                SearchView()
            }
            Tab("Upload", systemImage: Constants.uploadIconString) {
                UploadView()
            }
            Tab("Profile", systemImage: Constants.profileIconString) {
                ProfileView()
            }
        }
        .preferredColorScheme(colorSchemeValue)
    }
}

#Preview {
    ContentView()
}
