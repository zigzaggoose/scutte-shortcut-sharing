//
//  HomeViewModel.swift
//  shortcut hub
//

import Foundation

@Observable
class HomeViewModel {
    var mostStarredShortcuts = [
        Shortcut(title: "WiFi QR Code", description: "Generate a QR code for your WiFi network", stars: 3156, tags: ["Networking", "Sharing"], color: .teal, icon: "wifi"),
        Shortcut(title: "Morning Routine", description: "Get weather, news, and calendar events", stars: 2341, tags: ["Automation", "Morning"], color: .orange, icon: "sunrise.fill"),
        Shortcut(title: "Meeting Notes", description: "Create structured meeting notes", stars: 2089, tags: ["Productivity", "Work"], color: .blue, icon: "note.text"),
        Shortcut(title: "Quick Note", description: "Instantly create a new note with voice input", stars: 1847, tags: ["Productivity", "Notes"], color: .indigo, icon: "square.and.pencil")
    ]

    var productivityShortcuts = [
        Shortcut(title: "Quick Note", description: "Instantly create a new note with voice input", stars: 1847, tags: ["Productivity", "Notes"], color: .indigo, icon: "square.and.pencil"),
        Shortcut(title: "Meeting Notes", description: "Create structured meeting notes", stars: 2089, tags: ["Productivity", "Work"], color: .blue, icon: "note.text"),
        Shortcut(title: "Expense Tracker", description: "Log expenses quickly with voice input", stars: 1523, tags: ["Finance", "Productivity"], color: .green, icon: "dollarsign.circle.fill"),
        Shortcut(title: "Text Cleanup", description: "Remove formatting and clean up copied text", stars: 945, tags: ["Text", "Utilities"], color: .graphite, icon: "textformat")
    ]

    var automationShortcuts = [
        Shortcut(title: "Morning Routine", description: "Get weather, news, and calendar events", stars: 2341, tags: ["Automation", "Morning"], color: .orange, icon: "sunrise.fill"),
        Shortcut(title: "Battery Alert", description: "Get notified when battery reaches a percentage", stars: 678, tags: ["Battery", "Notifications"], color: .yellow, icon: "battery.75percent"),
        Shortcut(title: "Smart Home Control", description: "Control your smart home devices with one tap", stars: 1892, tags: ["Automation", "Smart Home"], color: .purple, icon: "house.fill"),
        Shortcut(title: "Auto Backup", description: "Automatically backup photos to cloud storage", stars: 1234, tags: ["Automation", "Storage"], color: .teal, icon: "icloud.and.arrow.up.fill")
    ]

    var newTrendingShortcuts = [
        Shortcut(title: "AI Text Summarizer", description: "Summarize long articles using AI", stars: 892, tags: ["AI", "Productivity"], color: .pink, icon: "brain.fill"),
        Shortcut(title: "Photo Watermark", description: "Add custom watermark to your photos", stars: 892, tags: ["Photography", "Editing"], color: .purple, icon: "camera.fill"),
        Shortcut(title: "Voice Translator", description: "Translate speech in real-time", stars: 756, tags: ["Translation", "Voice"], color: .orange, icon: "waveform"),
        Shortcut(title: "QR Scanner Pro", description: "Advanced QR code scanner with history", stars: 634, tags: ["Utilities", "Scanner"], color: .graphite, icon: "qrcode.viewfinder")
    ]
}
