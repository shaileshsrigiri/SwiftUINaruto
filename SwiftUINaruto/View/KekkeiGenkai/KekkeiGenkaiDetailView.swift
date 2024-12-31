//
//  KekkeiGenkaiDetailView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct KekkeiGenkaiDetailView: View {
    let kekkeiGenkai: KekkeiGenkai

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Kekkei Genkai Name
                headerView

                // Characters Section
                Text("Characters:")
                    .font(.title2)
                    .fontWeight(.semibold)

                ForEach(kekkeiGenkai.characters) { character in
                    NavigationLink(destination: KekkeiGenkaiCharacterDetailView(character: character)) {
                        characterRowView(character: character)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(kekkeiGenkai.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    // Header view for the Kekkei Genkai name
    private var headerView: some View {
        Text(kekkeiGenkai.name)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.bottom, 10)
    }

    // Row view for each character
    private func characterRowView(character: Character) -> some View {
        HStack {
            characterImageView(character: character)

            VStack(alignment: .leading, spacing: 5) {
                Text(character.name)
                    .font(.headline)
//                if let status = character.personal?.status {
//                    Text("Status: \(status)")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                }
            }
        }
        .padding(.vertical, 5)
    }

    // Image view for the character
    private func characterImageView(character: Character) -> some View {
        Group {
            if let imageUrl = character.images?.first, let url = URL(string: imageUrl) {
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
            } else {
                Image(systemName: "person.crop.circle.fill.badge.xmark")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }
        }
    }
}



//#Preview {
//    KekkeiGenkaiDetailView()
//}
