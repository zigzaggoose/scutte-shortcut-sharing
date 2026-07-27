//
//  HomeView.swift
//  shortcut hub
//
//  Created by Rishab Reji on 11/1/2026.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    DiscoverySection(
                        title: "Most Starred This Week",
                        shortcuts: viewModel.mostStarredShortcuts
                    )

                    DiscoverySection(
                        title: "Productivity",
                        shortcuts: viewModel.productivityShortcuts
                    )

                    DiscoverySection(
                        title: "Automation",
                        shortcuts: viewModel.automationShortcuts
                    )

                    DiscoverySection(
                        title: "New & Trending",
                        shortcuts: viewModel.newTrendingShortcuts
                    )
                }
                .padding(.vertical, 16)
            }
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Shortcut.self) { shortcut in
                ShortcutDetailView(shortcut: shortcut)
            }
        }
    }
}

// MARK: - Supporting Views

struct DiscoverySection: View {
    let title: String
    let shortcuts: [Shortcut]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)

                Spacer()

                NavigationLink {
                    CategoryListView(title: title, shortcuts: shortcuts)
                } label: {
                    Text("See All")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(shortcuts) { shortcut in
                        NavigationLink(value: shortcut) {
                            CompactShortcutCard(shortcut: shortcut)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct CompactShortcutCard: View {
    let shortcut: Shortcut

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Colored icon
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(shortcut.color.color.gradient)
                    .frame(width: 40, height: 40)
                Image(systemName: shortcut.icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }

            Text(shortcut.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .lineLimit(2)
                .frame(height: 38, alignment: .top)

            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(.yellow)
                Text(shortcut.stars.formattedCount)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(6)

            if !shortcut.tags.isEmpty {
                HStack(spacing: 4) {
                    ForEach(shortcut.tags.prefix(2), id: \.self) { tag in
                        TagPillView(tag: tag)
                    }
                }
            }

            Spacer()
        }
        .padding(12)
        .frame(width: 160, height: 170)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .overlay(
            shortcut.color.color
                .frame(height: 3)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)),
            alignment: .top
        )
        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
    }
}

#Preview {
    HomeView()
}
