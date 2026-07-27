//
//  CategoryListView.swift
//  shortcut hub
//

import SwiftUI

struct CategoryListView: View {
    let title: String
    let shortcuts: [Shortcut]

    var body: some View {
        ScrollView {
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
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large)
    }
}
