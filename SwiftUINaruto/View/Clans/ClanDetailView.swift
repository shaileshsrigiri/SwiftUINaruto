//
//  ClanDetailView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct ClanDetailView: View {
    let clan: Clan

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Clan Name
                Text(clan.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                // Characters
                ForEach(clan.characters) { character in
                    NavigationLink(destination: ClanCharacterDetailView(character: character)) {
                        ClanCharacterRow(character: character)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(clan.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct ClanCharacterRow: View {
    let character: Character

    var body: some View {
        HStack {
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
            }

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
}



//#Preview {
//    ClanDetailView()
//}
