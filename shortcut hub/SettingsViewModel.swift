//
//  SettingsViewModel.swift
//  shortcut hub
//

import SwiftUI

@Observable
class SettingsViewModel {
    // Appearance: 0 = system, 1 = light, 2 = dark
    var appColorScheme: Int {
        get { UserDefaults.standard.integer(forKey: "appColorScheme") }
        set { UserDefaults.standard.set(newValue, forKey: "appColorScheme") }
    }

    var colorSchemeValue: ColorScheme? {
        switch appColorScheme {
        case 1: return .light
        case 2: return .dark
        default: return nil
        }
    }

    // Notifications
    var notifyFollowers: Bool {
        get { UserDefaults.standard.bool(forKey: "notifyFollowers") }
        set { UserDefaults.standard.set(newValue, forKey: "notifyFollowers") }
    }

    var notifyUpdates: Bool {
        get { UserDefaults.standard.bool(forKey: "notifyUpdates") }
        set { UserDefaults.standard.set(newValue, forKey: "notifyUpdates") }
    }

    var notifyDigest: Bool {
        get { UserDefaults.standard.bool(forKey: "notifyDigest") }
        set { UserDefaults.standard.set(newValue, forKey: "notifyDigest") }
    }

    // General
    var defaultCategory: String {
        get { UserDefaults.standard.string(forKey: "defaultCategory") ?? "All" }
        set { UserDefaults.standard.set(newValue, forKey: "defaultCategory") }
    }

    // Alerts
    var showDeleteConfirmation = false
    var showClearCacheConfirmation = false

    // App info
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
}
