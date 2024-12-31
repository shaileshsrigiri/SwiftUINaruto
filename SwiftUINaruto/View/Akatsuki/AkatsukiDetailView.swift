//
//  AkatsukiDetailView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct AkatsukiDetailView: View {
    let member: Akatsuki

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Character Image
                if let imageUrl = member.images?.first, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
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
                }

                // Character Name
                Text(member.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Traits
                if let traits = member.uniqueTraits?.joined(separator: ", ") {
                    Text("Traits: \(traits)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }

                // Jutsu
                if let jutsu = member.jutsu?.joined(separator: ", ") {
                    Text("Jutsu: \(jutsu)")
                        .font(.headline)
                }

                // Nature Types
                if let natureTypes = member.natureType?.joined(separator: ", ") {
                    Text("Nature Types: \(natureTypes)")
                        .font(.headline)
                }

//                // Family
//                if let family = member.family {
//                    Text("Family: \(family.creator ?? "Unknown")")
//                        .font(.headline)
//                }

                // Voice Actors
                if let voiceActors = member.voiceActors {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Voice Actors")
                            .font(.title2)
                            .fontWeight(.bold)
                        if let japanese = voiceActors.japanese?.joined(separator: ", ") {
                            Text("Japanese: \(japanese)")
                        }
                        if let english = voiceActors.english?.joined(separator: ", ") {
                            Text("English: \(english)")
                        }
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(member.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


//#Preview {
//    AkatsukiDetailView()
//}
