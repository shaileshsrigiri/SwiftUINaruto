//
//  TailedBeastListView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct VillageDetailView: View {
    let village: Village

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                villageHeader
                characterList
            }
            .padding()
        }
        .navigationTitle(village.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    // Header for the village name
    private var villageHeader: some View {
        Text(village.name)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.bottom, 10)
    }

    // List of characters
    private var characterList: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Characters:")
                .font(.title2)
                .fontWeight(.semibold)

            ForEach(village.characters) { character in
                NavigationLink(destination: VillageCharacterDetailView(character: character)) {
                    characterRow(character: character)
                }
            }
        }
    }

    // A single row for a character
    private func characterRow(character: Character) -> some View {
        HStack {
            characterImage(for: character)
            VStack(alignment: .leading, spacing: 5) {
                Text(character.name)
                    .font(.headline)
//                if let affiliation = character.personal?.affiliation {
//                    Text("Affiliation: \(affiliation)")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                }
            }
        }
        .padding(.vertical, 5)
    }

    // AsyncImage for the character
    private func characterImage(for character: Character) -> some View {
        if let imageUrl = character.images?.first, let url = URL(string: imageUrl) {
            return AsyncImage(url: url) { phase in
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
            .eraseToAnyView()
        } else {
            return Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
                .eraseToAnyView()
        }
    }
}

// A helper extension to make type-checking easier
extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}



//#Preview {
//    TeamListView()
//}
