//
//  TagPillView.swift
//  shortcut hub
//

import SwiftUI

struct TagPillView: View {
    let tag: String

    private var tintColor: Color {
        ShortcutStyle.tagColor(for: tag)
    }

    var body: some View {
        Text(tag)
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundColor(tintColor.opacity(0.85))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(tintColor.opacity(0.10))
            .cornerRadius(8)
            .lineLimit(1)
    }
}
