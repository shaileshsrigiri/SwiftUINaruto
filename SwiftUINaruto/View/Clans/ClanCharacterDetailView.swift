//
//  ClanCharacterDetailView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct ClanCharacterDetailView: View {
    let character: Character

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Character Image
                if let imageUrl = character.images?.first, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        } else if phase.error != nil {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray)
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }

                // Character Name
                Text(character.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Jutsu
                if let jutsu = character.jutsu?.joined(separator: ", ") {
                    Text("Jutsu: \(jutsu)")
                        .font(.headline)
                }

                // Nature Types
                if let natureTypes = character.natureType?.joined(separator: ", ") {
                    Text("Nature Types: \(natureTypes)")
                        .font(.headline)
                }

//                // Personal Details
//                if let personal = character.personal {
//                    VStack(alignment: .leading, spacing: 5) {
//                        if let clan = personal.clan {
//                            Text("Clan: \(clan)")
//                        }
//                        if let occupation = personal.occupation?.joined(separator: ", ") {
//                            Text("Occupation: \(occupation)")
//                        }
//                        if let affiliation = personal.affiliation {
//                            Text("Affiliation: \(affiliation)")
//                        }
//                    }
//                }
            }
            .padding()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


//#Preview {
//    ClanCharacterDetailView()
//}
