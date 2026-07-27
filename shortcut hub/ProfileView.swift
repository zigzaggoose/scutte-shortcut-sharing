//
//  ProfileView.swift
//  shortcut hub
//
//  Created by Rishab Reji on 22/1/2026.
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    @Environment(AuthViewModel.self) private var authViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Profile Header Section
                    VStack(spacing: 16) {
                        HStack(alignment: .center, spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .indigo],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )

                            Spacer()

                            Button(action: {
                                // TODO: Connect to edit profile action
                            }) {
                                Text("Edit Profile")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 24)
                                    .background(Color(UIColor.secondarySystemBackground))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 12)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.displayName)
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("@\(viewModel.username)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)

                        Text(viewModel.bio)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)

                        HStack(spacing: 0) {
                            StatView(count: viewModel.shortcutsCount, label: "Shortcuts")

                            Divider()
                                .frame(height: 40)

                            StatView(count: viewModel.followersCount, label: "Followers")

                            Divider()
                                .frame(height: 40)

                            StatView(count: viewModel.followingCount, label: "Following")
                        }
                        .padding(.vertical, 16)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 24)

                    // Tab Selector
                    HStack(spacing: 0) {
                        ProfileTabButton(title: "Shortcuts", icon: "link.circle.fill", isSelected: viewModel.selectedTab == .shortcuts) {
                            viewModel.selectedTab = .shortcuts
                        }

                        ProfileTabButton(title: "Starred", icon: "star.fill", isSelected: viewModel.selectedTab == .starred) {
                            viewModel.selectedTab = .starred
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)

                    Divider()

                    // Content View
                    if viewModel.selectedTab == .shortcuts {
                        if viewModel.userShortcuts.isEmpty {
                            EmptyStateView(
                                icon: "link.circle",
                                title: "No Shortcuts Yet",
                                message: "Upload your first shortcut to share with the community"
                            )
                        } else {
                            ShortcutsListView(shortcuts: viewModel.userShortcuts)
                        }
                    } else {
                        if viewModel.starredShortcuts.isEmpty {
                            EmptyStateView(
                                icon: "star",
                                title: "No Starred Shortcuts",
                                message: "Star shortcuts you like to find them here later"
                            )
                        } else {
                            ShortcutsListView(shortcuts: viewModel.starredShortcuts)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: Constants.settingsIconString)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationDestination(for: Shortcut.self) { shortcut in
                ShortcutDetailView(shortcut: shortcut)
            }
        }
    }
}

// MARK: - Supporting Views

struct StatView: View {
    let count: Int
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(count.formattedCount)
                .font(.title2)
                .fontWeight(.bold)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfileTabButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: icon)
                        .font(.subheadline)
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(isSelected ? .indigo : .secondary)

                Rectangle()
                    .fill(isSelected ? Color.indigo : Color.clear)
                    .frame(height: 2)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ShortcutsListView: View {
    let shortcuts: [Shortcut]

    var body: some View {
        LazyVStack(spacing: 12) {
            ForEach(shortcuts) { shortcut in
                NavigationLink(value: shortcut) {
                    ShortcutCard(shortcut: shortcut)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

#Preview {
    ProfileView()
        .environment(AuthViewModel())
}
