//
//  UploadView.swift
//  shortcut hub
//
//  Created by Rishab Reji on 18/1/2026.
//

import SwiftUI
import PhotosUI

struct UploadView: View {
    @State private var viewModel = UploadViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {

                    // MARK: - Content Section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "Content", icon: "doc.text.fill")

                        VStack(spacing: 12) {
                            // Title Field
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text("Title")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text("\(viewModel.title.count)/\(UploadViewModel.titleLimit)")
                                        .font(.caption)
                                        .foregroundColor(viewModel.title.count > UploadViewModel.titleLimit ? .red : .secondary)
                                }
                                TextField("Enter a catchy title", text: $viewModel.title)
                                    .padding(14)
                                    .background(Color(UIColor.secondarySystemBackground))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(viewModel.titleError != nil ? Color.red.opacity(0.5) : Color.blue.opacity(viewModel.title.isEmpty ? 0 : 0.3), lineWidth: 1)
                                    )
                                if let error = viewModel.titleError {
                                    Text(error)
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }

                            // Description Field
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text("Description")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text("\(viewModel.description.count)/\(UploadViewModel.descriptionLimit)")
                                        .font(.caption)
                                        .foregroundColor(viewModel.description.count > UploadViewModel.descriptionLimit ? .red : .secondary)
                                }
                                ZStack(alignment: .topLeading) {
                                    if viewModel.description.isEmpty {
                                        Text("Describe your shortcut in detail...")
                                            .foregroundColor(.gray.opacity(0.5))
                                            .padding(.horizontal, 18)
                                            .padding(.vertical, 18)
                                    }
                                    TextEditor(text: $viewModel.description)
                                        .scrollContentBackground(.hidden)
                                        .frame(height: 120)
                                        .padding(8)
                                }
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(viewModel.descriptionError != nil ? Color.red.opacity(0.5) : Color.blue.opacity(viewModel.description.isEmpty ? 0 : 0.3), lineWidth: 1)
                                )
                                if let error = viewModel.descriptionError {
                                    Text(error)
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }

                            // Link Field
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Shortcut Link")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.secondary)
                                HStack {
                                    Image(systemName: "link")
                                        .foregroundColor(.secondary)
                                    TextField("https://www.icloud.com/shortcuts/...", text: $viewModel.link)
                                        .keyboardType(.URL)
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled()
                                }
                                .padding(14)
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(viewModel.linkError != nil ? Color.red.opacity(0.5) : Color.blue.opacity(viewModel.link.isEmpty ? 0 : 0.3), lineWidth: 1)
                                )
                                if let error = viewModel.linkError {
                                    Text(error)
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }

                    // MARK: - Media Section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "Media", icon: "photo.fill")

                        PhotosPicker(
                            selection: $viewModel.selectedPhotosItems,
                            maxSelectionCount: 5,
                            matching: .images
                        ) {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(UIColor.secondarySystemBackground))
                                .frame(height: 140)
                                .overlay {
                                    VStack(spacing: 12) {
                                        Image(systemName: "photo.badge.plus")
                                            .font(.system(size: 40))
                                            .foregroundColor(.blue)
                                        Text(viewModel.selectedImageData.isEmpty ? "Add Screenshots" : "Change Screenshots")
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                        Text("Show how your shortcut works (up to 5)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                                        .foregroundColor(.blue.opacity(0.3))
                                )
                        }
                        .onChange(of: viewModel.selectedPhotosItems) {
                            Task {
                                await viewModel.loadImages()
                            }
                        }

                        // Selected images thumbnails
                        if !viewModel.selectedImageData.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(Array(viewModel.selectedImageData.enumerated()), id: \.offset) { index, data in
                                        if let uiImage = UIImage(data: data) {
                                            ZStack(alignment: .topTrailing) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 80, height: 80)
                                                    .cornerRadius(10)
                                                    .clipped()

                                                Button {
                                                    withAnimation {
                                                        viewModel.removeImage(at: index)
                                                    }
                                                } label: {
                                                    Image(systemName: "xmark.circle.fill")
                                                        .font(.title3)
                                                        .foregroundColor(.white)
                                                        .background(Circle().fill(.black.opacity(0.5)))
                                                }
                                                .offset(x: 6, y: -6)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // MARK: - Tags Section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "Tags", icon: "tag.fill")

                        if !viewModel.selectedTags.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.selectedTags, id: \.self) { tag in
                                        TagChip(tag: tag) {
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                viewModel.selectedTags.removeAll { $0 == tag }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Button(action: {
                            viewModel.showTagSheet = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.title3)
                                Text(viewModel.selectedTags.isEmpty ? "Add tags to help others find your shortcut" : "Add more tags")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                            .padding(16)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                        }
                    }

                    // Submit Button
                    Button(action: {
                        // TODO: Connect to backend submission
                    }) {
                        HStack {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.title3)
                            Text("Publish Shortcut")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .blue.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(14)
                        .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .disabled(!viewModel.isValid)
                    .opacity(viewModel.isValid ? 1.0 : 0.6)
                    .padding(.top, 8)
                }
                .padding(20)
            }
            .navigationTitle("Upload")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $viewModel.showTagSheet) {
                TagSelectionSheet(
                    selectedTags: $viewModel.selectedTags,
                    tagSearchText: $viewModel.tagSearchText,
                    showTagSheet: $viewModel.showTagSheet
                )
            }
        }
    }
}

// MARK: - Supporting Views

struct SectionHeader: View {
    let title: String
    let icon: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.subheadline)
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}

struct TagChip: View {
    let tag: String
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: 6) {
            Text(tag)
                .font(.subheadline)
                .fontWeight(.medium)
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.15), Color.blue.opacity(0.1)]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
        )
    }
}

struct TagSelectionSheet: View {
    @Binding var selectedTags: [String]
    @Binding var tagSearchText: String
    @Binding var showTagSheet: Bool

    var filteredTags: [String] {
        Constants.availableTags.filter { tag in
            tagSearchText.isEmpty || tag.localizedCaseInsensitiveContains(tagSearchText)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredTags, id: \.self) { tag in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            if selectedTags.contains(tag) {
                                selectedTags.removeAll { $0 == tag }
                            } else {
                                selectedTags.append(tag)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "tag.fill")
                                .foregroundColor(.blue)
                                .font(.subheadline)
                            Text(tag)
                                .foregroundColor(.primary)
                                .font(.body)
                            Spacer()
                            if selectedTags.contains(tag) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.title3)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .searchable(text: $tagSearchText, prompt: "Search tags")
            .navigationTitle("Select Tags")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        selectedTags.removeAll()
                    }
                    .disabled(selectedTags.isEmpty)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        tagSearchText = ""
                        showTagSheet = false
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    UploadView()
}
