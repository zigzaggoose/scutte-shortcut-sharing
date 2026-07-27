//
//  SearchView.swift
//  shortcut hub
//
//  Created by Rishab Reji on 17/1/2026.
//

import SwiftUI

struct SearchView: View {
    @State private var viewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    if viewModel.filteredItems.isEmpty && !viewModel.searchText.isEmpty {
                        EmptyStateView(
                            icon: "magnifyingglass",
                            title: "No Results",
                            message: "Try a different search term"
                        )
                    } else {
                        ForEach(viewModel.filteredItems) { item in
                            NavigationLink(value: item) {
                                SearchItemCard(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .searchable(text: $viewModel.searchText, prompt: "Search shortcuts, users, or tags")
            .navigationTitle("Search")
            .navigationDestination(for: Shortcut.self) { shortcut in
                ShortcutDetailView(shortcut: shortcut)
            }
        }
    }
}

// MARK: - Search Item Card

struct SearchItemCard: View {
    let item: Shortcut

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header: Profile info and stars
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: item.profilePicture)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundStyle(item.color.color.gradient)

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.userName)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)

                    HStack(spacing: 3) {
                        Image(systemName: "person.2.fill")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text("\(item.followers.formattedCount) followers")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                StarRatingView(stars: item.stars)
            }
            .padding(12)

            Divider()
                .overlay(item.color.color.opacity(0.3))
                .padding(.horizontal, 16)

            // Content Section
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(item.color.color.gradient)
                        .frame(width: 40, height: 40)
                    Image(systemName: item.icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(item.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(2)

                if !item.tags.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            ForEach(item.tags, id: \.self) { tag in
                                TagPillView(tag: tag)
                            }
                        }
                    }
                }

                    Text(item.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .lineSpacing(2)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    SearchView()
}
