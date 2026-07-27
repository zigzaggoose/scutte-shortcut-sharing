//
//  UploadViewModel.swift
//  shortcut hub
//

import Foundation
import PhotosUI
import SwiftUI

@Observable
class UploadViewModel {
    var title = ""
    var description = ""
    var link = ""
    var selectedTags: [String] = []
    var showTagSheet = false
    var tagSearchText = ""

    var selectedPhotosItems: [PhotosPickerItem] = []
    var selectedImageData: [Data] = []

    static let titleLimit = 100
    static let descriptionLimit = 500

    // MARK: - Validation

    var titleError: String? {
        guard !title.isEmpty else { return nil }
        if title.count > Self.titleLimit {
            return "Title must be \(Self.titleLimit) characters or less"
        }
        return nil
    }

    var descriptionError: String? {
        guard !description.isEmpty else { return nil }
        if description.count > Self.descriptionLimit {
            return "Description must be \(Self.descriptionLimit) characters or less"
        }
        return nil
    }

    var linkError: String? {
        guard !link.isEmpty else { return nil }
        guard let url = URL(string: link),
              let scheme = url.scheme,
              ["http", "https"].contains(scheme.lowercased()),
              url.host != nil else {
            return "Enter a valid URL (e.g. https://www.icloud.com/shortcuts/...)"
        }
        return nil
    }

    var isValid: Bool {
        !title.isEmpty &&
        !link.isEmpty &&
        titleError == nil &&
        descriptionError == nil &&
        linkError == nil
    }

    // MARK: - Image Handling

    func loadImages() async {
        var newData: [Data] = []
        for item in selectedPhotosItems {
            if let data = try? await item.loadTransferable(type: Data.self) {
                newData.append(data)
            }
        }
        selectedImageData = newData
    }

    func removeImage(at index: Int) {
        guard index < selectedImageData.count else { return }
        selectedImageData.remove(at: index)
        if index < selectedPhotosItems.count {
            selectedPhotosItems.remove(at: index)
        }
    }
}
