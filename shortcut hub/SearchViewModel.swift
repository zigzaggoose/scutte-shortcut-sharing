//
//  SearchViewModel.swift
//  shortcut hub
//

import Foundation

@Observable
class SearchViewModel {
    var searchText = ""

    let sampleItems = [
        Shortcut(profilePicture: "person.circle.fill", userName: "gangatron AI", title: "First Post", description: "This is my first post description", followers: 50, stars: 18293, tags: ["Productivity", "Shortcuts", "Automation"], color: .blue, icon: "checkmark.circle.fill"),
        Shortcut(profilePicture: "person.circle.fill", userName: "jane_smith", title: "Amazing Experience", description: "Had a great time trying this out", followers: 4, stars: 129, tags: ["Instagram", "Social Media"], color: .pink, icon: "heart.circle.fill"),
        Shortcut(profilePicture: "person.circle.fill", userName: "bob_jones", title: "Quick Review", description: "Pretty good overall, would recommend", followers: 3, stars: 759, tags: ["iPhone", "Apple", "Settings"], color: .indigo, icon: "gearshape.fill"),
        Shortcut(profilePicture: "person.circle.fill", userName: "alice_wonder", title: "Incredible!", description: "Absolutely loved everything about this", followers: 5, stars: 1290, tags: ["Photography", "Video", "Entertainment"], color: .purple, icon: "camera.fill"),
        Shortcut(profilePicture: "person.circle.fill", userName: "john_doe", title: "First Post", description: "This is my first post description", followers: 5, stars: 572, tags: ["Automation", "Productivity"], color: .teal, icon: "gearshape.2.fill"),
        Shortcut(profilePicture: "person.circle.fill", userName: "jane_smith", title: "Amazing Experience", description: "Had a great time trying this out", followers: 4, stars: 158, tags: ["Travel", "Photography"], color: .yellow, icon: "airplane"),
        Shortcut(profilePicture: "person.circle.fill", userName: "bob_jones", title: "Quick Review", description: "Pretty good overall, would recommend", followers: 3, stars: 300, tags: ["Music", "Entertainment"], color: .orange, icon: "music.note"),
        Shortcut(profilePicture: "person.circle.fill", userName: "alice_wonder", title: "Incredible!", description: "Absolutely loved everything about this", followers: 5, stars: 120, tags: ["Fitness", "Health"], color: .red, icon: "heart.fill")
    ]

    var filteredItems: [Shortcut] {
        if searchText.isEmpty {
            return sampleItems
        }
        return sampleItems.filter { item in
            item.title.localizedCaseInsensitiveContains(searchText) ||
            item.description.localizedCaseInsensitiveContains(searchText) ||
            item.userName.localizedCaseInsensitiveContains(searchText)
        }
    }
}
