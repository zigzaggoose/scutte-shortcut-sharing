//
//  Int+Formatting.swift
//  shortcut hub
//

import Foundation

extension Int {
    var formattedCount: String {
        if self >= 1_000_000 {
            return String(format: "%.1fM", Double(self) / 1_000_000.0)
        } else if self >= 1_000 {
            return String(format: "%.1fK", Double(self) / 1_000.0)
        }
        return "\(self)"
    }
}
