//
//  SettingsView.swift
//  shortcut hub
//

import SwiftUI

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    @Environment(AuthViewModel.self) private var authViewModel

    var body: some View {
        Form {
            // MARK: - Appearance
            Section {
                Picker(selection: $viewModel.appColorScheme) {
                    Text("System").tag(0)
                    Text("Light").tag(1)
                    Text("Dark").tag(2)
                } label: {
                    Label("Appearance", systemImage: "paintbrush.fill")
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Appearance")
            }

            // MARK: - Notifications
            Section {
                Toggle(isOn: $viewModel.notifyFollowers) {
                    Label("New Followers", systemImage: "person.badge.plus")
                }

                Toggle(isOn: $viewModel.notifyUpdates) {
                    Label("Shortcut Updates", systemImage: "arrow.triangle.2.circlepath")
                }

                Toggle(isOn: $viewModel.notifyDigest) {
                    Label("Weekly Digest", systemImage: "envelope.fill")
                }
            } header: {
                Text("Notifications")
            }

            // MARK: - General
            Section {
                Picker(selection: $viewModel.defaultCategory) {
                    Text("All").tag("All")
                    ForEach(Constants.availableTags, id: \.self) { tag in
                        Text(tag).tag(tag)
                    }
                } label: {
                    Label("Default Category", systemImage: "line.3.horizontal.decrease.circle.fill")
                }

                Button(action: {
                    viewModel.showClearCacheConfirmation = true
                }) {
                    Label("Clear Cache", systemImage: "trash.fill")
                        .foregroundColor(.primary)
                }
            } header: {
                Text("General")
            }

            // MARK: - Account
            Section {
                NavigationLink {
                    PlaceholderSettingsDetail(title: "Edit Profile", icon: "person.crop.circle", description: "Profile editing will be available in a future update.")
                } label: {
                    Label("Edit Profile", systemImage: "person.crop.circle")
                }

                NavigationLink {
                    PlaceholderSettingsDetail(title: "Change Password", icon: "lock.rotation", description: "Password management will be available in a future update.")
                } label: {
                    Label("Change Password", systemImage: "lock.rotation")
                }

                Button(action: {
                    authViewModel.logout()
                }) {
                    Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.red)
                }

                Button(action: {
                    viewModel.showDeleteConfirmation = true
                }) {
                    Label("Delete Account", systemImage: "xmark.circle.fill")
                        .foregroundColor(.red)
                }
            } header: {
                Text("Account")
            }

            // MARK: - About
            Section {
                Link(destination: URL(string: "https://apps.apple.com")!) {
                    Label("Rate Scuttle", systemImage: "star.fill")
                        .foregroundColor(.primary)
                }

                NavigationLink {
                    PlaceholderSettingsDetail(title: "Privacy Policy", icon: "hand.raised.fill", description: "Our privacy policy will be available here.")
                } label: {
                    Label("Privacy Policy", systemImage: "hand.raised.fill")
                }

                NavigationLink {
                    PlaceholderSettingsDetail(title: "Terms of Service", icon: "doc.text.fill", description: "Our terms of service will be available here.")
                } label: {
                    Label("Terms of Service", systemImage: "doc.text.fill")
                }

                HStack {
                    Label("Version", systemImage: "info.circle.fill")
                    Spacer()
                    Text("\(viewModel.appVersion) (\(viewModel.buildNumber))")
                        .foregroundColor(.secondary)
                }
            } header: {
                Text("About")
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Clear Cache", isPresented: $viewModel.showClearCacheConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Clear", role: .destructive) {
                // Placeholder: clear cache action
            }
        } message: {
            Text("This will remove all cached data. Your account and shortcuts will not be affected.")
        }
        .alert("Delete Account", isPresented: $viewModel.showDeleteConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                authViewModel.logout()
            }
        } message: {
            Text("This action is permanent and cannot be undone. All your shortcuts and data will be deleted.")
        }
    }
}

// MARK: - Placeholder Detail View

struct PlaceholderSettingsDetail: View {
    let title: String
    let icon: String
    let description: String

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundStyle(.secondary)

            Text(title)
                .font(.title2)
                .fontWeight(.bold)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environment(AuthViewModel())
    }
}
