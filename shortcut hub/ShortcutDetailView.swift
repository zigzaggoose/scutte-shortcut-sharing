//
//  ShortcutDetailView.swift
//  shortcut hub
//

import SwiftUI

struct ShortcutDetailView: View {
    let shortcut: Shortcut
    @State private var isStarred: Bool
    @Environment(\.openURL) private var openURL

    init(shortcut: Shortcut) {
        self.shortcut = shortcut
        self._isStarred = State(initialValue: shortcut.isStarred)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Hero Section
                VStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(shortcut.color.color.gradient)
                            .frame(width: 72, height: 72)
                        Image(systemName: shortcut.icon)
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundColor(.white)
                    }

                    Text(shortcut.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    StarRatingView(stars: shortcut.stars)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 28)
                .padding(.horizontal, 20)
                .background(
                    shortcut.color.color.opacity(0.08)
                        .ignoresSafeArea(edges: .top)
                )

                VStack(alignment: .leading, spacing: 24) {
                    // Author Header
                    if !shortcut.userName.isEmpty {
                        HStack(spacing: 12) {
                            Image(systemName: shortcut.profilePicture)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                                .foregroundStyle(shortcut.color.color.gradient)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(shortcut.userName)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                if shortcut.followers > 0 {
                                    HStack(spacing: 3) {
                                        Image(systemName: "person.2.fill")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                        Text("\(shortcut.followers.formattedCount) followers")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }

                            Spacer()
                        }
                    }

                    // About
                    VStack(alignment: .leading, spacing: 8) {
                        Text("About")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)

                        Text(shortcut.description)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                    }

                // Tags
                if !shortcut.tags.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tags")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)

                        FlowLayout(spacing: 8) {
                            ForEach(shortcut.tags, id: \.self) { tag in
                                TagPillView(tag: tag)
                            }
                        }
                    }
                }

                Spacer(minLength: 16)

                // Action Buttons
                VStack(spacing: 12) {
                    // Star Toggle
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isStarred.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: isStarred ? "star.fill" : "star")
                                .font(.title3)
                            Text(isStarred ? "Starred" : "Star this Shortcut")
                                .font(.headline)
                        }
                        .foregroundColor(isStarred ? .yellow : .primary)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(isStarred ? Color.yellow.opacity(0.1) : Color(UIColor.secondarySystemBackground))
                        .cornerRadius(14)
                    }

                    // Get Shortcut Button
                    Button(action: {
                        if let urlString = shortcut.shortcutURL,
                           let url = URL(string: urlString) {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.down.circle.fill")
                                .font(.title3)
                            Text("Get Shortcut")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [shortcut.color.color, shortcut.color.color.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(14)
                        .shadow(color: shortcut.color.color.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .disabled(shortcut.shortcutURL == nil)
                    .opacity(shortcut.shortcutURL == nil ? 0.6 : 1.0)
                }
                }
                .padding(20)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Flow Layout for Tags

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.positions[index].x,
                                      y: bounds.minY + result.positions[index].y),
                          proposal: .unspecified)
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (positions: [CGPoint], size: CGSize) {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var maxX: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            positions.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
            maxX = max(maxX, x - spacing)
        }

        return (positions, CGSize(width: maxX, height: y + rowHeight))
    }
}
