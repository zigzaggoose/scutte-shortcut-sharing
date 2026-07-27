//
//  ShortcutStyle.swift
//  shortcut hub
//

import SwiftUI

enum ShortcutColor: String, CaseIterable {
    case red, orange, yellow, green, teal, blue, indigo, purple, pink, graphite

    var color: Color {
        switch self {
        case .red: Color(red: 0.94, green: 0.28, blue: 0.30)
        case .orange: Color(red: 0.96, green: 0.58, blue: 0.12)
        case .yellow: Color(red: 0.95, green: 0.77, blue: 0.06)
        case .green: Color(red: 0.22, green: 0.78, blue: 0.45)
        case .teal: Color(red: 0.18, green: 0.75, blue: 0.73)
        case .blue: Color(red: 0.20, green: 0.49, blue: 0.96)
        case .indigo: Color(red: 0.36, green: 0.32, blue: 0.86)
        case .purple: Color(red: 0.66, green: 0.34, blue: 0.87)
        case .pink: Color(red: 0.92, green: 0.34, blue: 0.60)
        case .graphite: Color(red: 0.55, green: 0.55, blue: 0.58)
        }
    }

    var lightBackground: Color {
        color.opacity(0.12)
    }
}

struct ShortcutStyle {
    static func tagColor(for tag: String) -> Color {
        let mapping: [String: ShortcutColor] = [
            "Productivity": .blue, "Work": .blue, "Notes": .blue,
            "Automation": .teal, "Smart Home": .teal,
            "Social Media": .pink, "Instagram": .pink, "WhatsApp": .pink,
            "Photography": .purple, "Video": .purple, "Editing": .purple,
            "Finance": .green, "Shopping": .green,
            "Health": .red, "Fitness": .red,
            "Music": .orange, "Entertainment": .orange, "Gaming": .orange,
            "Travel": .yellow, "Food": .yellow, "Morning": .yellow,
            "iPhone": .indigo, "iPad": .indigo, "Mac": .indigo,
            "Apple": .indigo, "Settings": .indigo,
            "Networking": .teal, "Sharing": .teal,
            "AI": .pink, "Translation": .pink, "Voice": .pink,
            "Battery": .yellow, "Notifications": .orange,
            "Utilities": .graphite, "Scanner": .graphite, "Text": .graphite,
            "Shortcuts": .blue, "Reminders": .blue, "Calendar": .blue,
            "Weather": .teal, "News": .indigo,
            "Education": .indigo, "Communication": .blue,
            "Storage": .green, "Tesla": .red,
        ]
        return mapping[tag]?.color ?? ShortcutColor.graphite.color
    }
}
