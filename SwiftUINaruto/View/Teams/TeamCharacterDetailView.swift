//
//  TailedBeastListView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct TeamCharacterDetailView: View {
    let character: Character

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Character Name
                Text(character.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                // Character Image
                if let imageUrl = character.images?.first, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                        } else if phase.error != nil {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.gray)
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(height: 200)
                    .padding(.bottom, 10)
                }

//                // Personal Info
//                if let personal = character.personal {
//                    Text("Personal Information:")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                    if let birthdate = personal.birthdate {
//                        Text("Birthdate: \(birthdate)")
//                            .font(.body)
//                    }
//                    if let sex = personal.sex {
//                        Text("Sex: \(sex)")
//                            .font(.body)
//                    }
//                    if let status = personal.status {
//                        Text("Status: \(status)")
//                            .font(.body)
//                    }
//                }

                // Nature Types
                if let natureTypes = character.natureType {
                    Text("Nature Types:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    ForEach(natureTypes, id: \.self) { natureType in
                        Text(natureType)
                            .font(.body)
                            .padding(.leading, 10)
                    }
                }

                // Jutsu
                if let jutsuList = character.jutsu {
                    Text("Jutsu:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    ForEach(jutsuList, id: \.self) { jutsu in
                        Text(jutsu)
                            .font(.body)
                            .padding(.leading, 10)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
