//
//  TailedBeastListView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct TeamDetailView: View {
    let team: Team

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Team Name
                Text(team.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                // Characters
                Text("Members:")
                    .font(.title2)
                    .fontWeight(.semibold)

                ForEach(team.characters) { character in
                    NavigationLink(destination: TeamCharacterDetailView(character: character)) {
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
//                                if let status = character.personal?.status {
//                                    Text("Status: \(status)")
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                }
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(team.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
