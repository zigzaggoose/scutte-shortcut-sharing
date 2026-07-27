//
//  ProfileViewModel.swift
//  shortcut hub
//

import Foundation

enum ProfileTab {
    case shortcuts
    case starred
}

@Observable
class ProfileViewModel {
    var selectedTab = ProfileTab.shortcuts

    let username = "placeholder_username"
    let displayName = "Placeholder User"
    let bio = "iOS Shortcuts enthusiast | Automation lover | Sharing my favorite shortcuts with the community"
    let shortcutsCount = 24
    let followersCount = 1847
    let followingCount = 342

    let userShortcuts = [
        Shortcut(title: "Quick Note", description: "Instantly create a new note with voice input and save it to your Notes app", stars: 1847, tags: ["Productivity", "Notes"], color: .indigo, icon: "square.and.pencil"),
        Shortcut(title: "Morning Routine", description: "Get weather, news, and calendar events all in one go", stars: 2341, tags: ["Automation", "Morning"], color: .orange, icon: "sunrise.fill"),
        Shortcut(title: "Photo Watermark", description: "Add custom watermark to your photos before sharing", stars: 892, tags: ["Photography", "Editing"], color: .purple, icon: "camera.fill"),
        Shortcut(title: "WiFi QR Code", description: "Generate a QR code for your WiFi network to share with guests", stars: 3156, tags: ["Networking", "Sharing"], color: .teal, icon: "wifi"),
        Shortcut(title: "Expense Tracker", description: "Log expenses quickly with voice input and automatic categorization", stars: 1523, tags: ["Finance", "Productivity"], color: .green, icon: "dollarsign.circle.fill"),
        Shortcut(title: "Battery Alert", description: "Get notified when your battery reaches a specific percentage", stars: 678, tags: ["Battery", "Notifications"], color: .yellow, icon: "battery.75percent"),
        Shortcut(title: "Text Cleanup", description: "Remove formatting and clean up copied text instantly", stars: 945, tags: ["Text", "Utilities"], color: .graphite, icon: "textformat"),
        Shortcut(title: "Meeting Notes", description: "Create structured meeting notes with timestamps and action items", stars: 2089, tags: ["Productivity", "Work"], color: .blue, icon: "note.text")
    ]

    let starredShortcuts = [
        Shortcut(title: "WiFi QR Code", description: "Generate a QR code for your WiFi network to share with guests", stars: 3156, tags: ["Networking", "Sharing"], color: .teal, icon: "wifi"),
        Shortcut(title: "Morning Routine", description: "Get weather, news, and calendar events all in one go", stars: 2341, tags: ["Automation", "Morning"], color: .orange, icon: "sunrise.fill"),
        Shortcut(title: "Meeting Notes", description: "Create structured meeting notes with timestamps and action items", stars: 2089, tags: ["Productivity", "Work"], color: .blue, icon: "note.text"),
        Shortcut(title: "Quick Note", description: "Instantly create a new note with voice input and save it to your Notes app", stars: 1847, tags: ["Productivity", "Notes"], color: .indigo, icon: "square.and.pencil"),
        Shortcut(title: "Expense Tracker", description: "Log expenses quickly with voice input and automatic categorization", stars: 1523, tags: ["Finance", "Productivity"], color: .green, icon: "dollarsign.circle.fill")
    ]
}
