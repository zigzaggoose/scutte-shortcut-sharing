//
//  Shortcut.swift
//  shortcut hub
//

import Foundation

struct Shortcut: Identifiable, Hashable {
    let id = UUID()
    var profilePicture: String
    var userName: String
    var title: String
    var description: String
    var followers: Int
    var stars: Int
    var tags: [String]
    var shortcutURL: String?
    var isStarred: Bool
    var color: ShortcutColor
    var icon: String

    static func == (lhs: Shortcut, rhs: Shortcut) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(
        profilePicture: String = "person.circle.fill",
        userName: String = "",
        title: String,
        description: String,
        followers: Int = 0,
        stars: Int,
        tags: [String],
        shortcutURL: String? = nil,
        isStarred: Bool = false,
        color: ShortcutColor = .blue,
        icon: String = "command.circle.fill"
    ) {
        self.profilePicture = profilePicture
        self.userName = userName
        self.title = title
        self.description = description
        self.followers = followers
        self.stars = stars
        self.tags = tags
        self.shortcutURL = shortcutURL
        self.isStarred = isStarred
        self.color = color
        self.icon = icon
    }
}
