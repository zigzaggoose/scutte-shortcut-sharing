//
//  ShortcutCard.swift
//  shortcut hub
//

import SwiftUI

struct ShortcutCard: View {
    let shortcut: Shortcut

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Colored icon
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(shortcut.color.color.gradient)
                    .frame(width: 40, height: 40)
                Image(systemName: shortcut.icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Text(shortcut.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(2)

                    Spacer()

                    StarRatingView(stars: shortcut.stars)
                }

                if !shortcut.tags.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            ForEach(shortcut.tags, id: \.self) { tag in
                                TagPillView(tag: tag)
                            }
                        }
                    }
                }

                Text(shortcut.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .lineSpacing(2)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .fill(shortcut.color.color)
                .frame(width: 3)
                .padding(.vertical, 12),
            alignment: .leading
        )
        .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 2)
    }
}
