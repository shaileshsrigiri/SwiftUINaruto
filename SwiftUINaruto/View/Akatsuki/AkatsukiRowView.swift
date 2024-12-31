//
//  AkatsukiRowView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct AkatsukiRowView: View {
    let member: Akatsuki

    var body: some View {
        HStack {
            if let imageUrl = member.images?.first, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } else if phase.error != nil {
                        Image(systemName: "person.crop.circle.fill.badge.xmark")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                    } else {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }
                }
                .padding(.trailing, 10)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(member.name)
                    .font(.headline)
                if let traits = member.uniqueTraits?.joined(separator: ", ") {
                    Text("Traits: \(traits)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 5)
    }
}


//#Preview {
//    AkatsukiRowView()
//}
