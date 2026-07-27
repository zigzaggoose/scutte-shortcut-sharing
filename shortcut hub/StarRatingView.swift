//
//  StarRatingView.swift
//  shortcut hub
//

import SwiftUI

struct StarRatingView: View {
    let stars: Int

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .font(.subheadline)
                .foregroundColor(.yellow)
            Text(stars.formattedCount)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color(UIColor.tertiarySystemBackground))
        .cornerRadius(8)
    }
}
