//
//  CharacterDetailView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/29/24.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Character Image
                if let imageUrl = character.images?.first, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .padding()
                                .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                        } else if phase.error != nil {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        } else {
                            ProgressView()
                                .frame(width: 200, height: 200)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }

                // Name
                Text(character.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)

                Divider()

                // Debut
                if let debut = character.debut {
                    SectionHeader(title: "Debut")
                    VStack(alignment: .leading, spacing: 5) {
                        if let manga = debut.manga { DetailRow(title: "Manga", value: manga) }
                        if let anime = debut.anime { DetailRow(title: "Anime", value: anime) }
                        if let appearsIn = debut.appearsIn { DetailRow(title: "Appears In", value: appearsIn) }
                    }
                    .padding(.horizontal)
                }

                // Jutsu
                if let jutsu = character.jutsu, !jutsu.isEmpty {
                    SectionHeader(title: "Jutsu")
                    ForEach(jutsu, id: \.self) { technique in
                        Text("• \(technique)")
                            .font(.body)
                    }
                    .padding(.horizontal)
                }

                // Unique Traits
                if let traits = character.uniqueTraits, !traits.isEmpty {
                    SectionHeader(title: "Unique Traits")
                    ForEach(traits, id: \.self) { trait in
                        Text("• \(trait)")
                            .font(.body)
                    }
                    .padding(.horizontal)
                }

                // Nature Type
                if let natureType = character.natureType, !natureType.isEmpty {
                    SectionHeader(title: "Nature Type")
                    Text(natureType.joined(separator: ", "))
                        .font(.body)
                        .padding(.horizontal)
                }

//                // Rank
//                if let rank = character.rank?.ninjaRank?.values.joined(separator: ", ") {
//                    SectionHeader(title: "Rank")
//                    Text(rank)
//                        .font(.body)
//                        .padding(.horizontal)
//                }

                // Voice Actors
                if let voiceActors = character.voiceActors {
                    SectionHeader(title: "Voice Actors")
                    VStack(alignment: .leading) {
                        if let japanese = voiceActors.japanese?.joined(separator: ", ") {
                            Text("Japanese: \(japanese)")
                        }
                        if let english = voiceActors.english?.joined(separator: ", ") {
                            Text("English: \(english)")
                        }
                    }
                    .padding(.horizontal)
                }

                // Family
                if let family = character.family {
                    SectionHeader(title: "Family")
                    VStack(alignment: .leading) {
                        if let father = family.father { DetailRow(title: "Father", value: father) }
                        if let mother = family.mother { DetailRow(title: "Mother", value: mother) }
                        if let son = family.son { DetailRow(title: "Son", value: son) }
                        if let brother = family.brother { DetailRow(title: "Brother", value: brother) }
                        if let husband = family.husband { DetailRow(title: "Husband", value: husband) }
                        if let cousin = family.cousin { DetailRow(title: "Cousin", value: cousin) }
                    }
                    .padding(.horizontal)
                }

//                // Personal Details
//                if let personal = character.personal {
//                    SectionHeader(title: "Personal Details")
//                    VStack(alignment: .leading, spacing: 10) {
//                        if let status = personal.status { DetailRow(title: "Status", value: status) }
//                        if let clan = personal.clan { DetailRow(title: "Clan", value: clan) }
//                        if let team = personal.team?.joined(separator: ", ") {
//                            DetailRow(title: "Team", value: team)
//                        }
//                        if let kekkeiGenkai = personal.kekkeiGenkai {
//                            DetailRow(title: "Kekkei Genkai", value: kekkeiGenkai)
//                        }
//                        if let jinchūriki = personal.jinchūriki?.joined(separator: ", ") {
//                            DetailRow(title: "Jinchūriki", value: jinchūriki)
//                        }
//                        if let occupation = personal.occupation?.joined(separator: ", ") {
//                            DetailRow(title: "Occupation", value: occupation)
//                        }
//                        if let affiliation = personal.affiliation?.joined(separator: ", ") {
//                            DetailRow(title: "Affiliation", value: affiliation)
//                        }
//                    }
//                    .padding(.horizontal)
//                }

                // Tools
                if let tools = character.tools, !tools.isEmpty {
                    SectionHeader(title: "Tools")
                    ForEach(tools, id: \.self) { tool in
                        Text("• \(tool)")
                            .font(.body)
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Custom UI Components
struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.blue)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}

struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text("\(title):")
                .fontWeight(.bold)
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

