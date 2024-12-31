//
//  KaraDetailView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct KaraDetailView: View {
    let member: Kara

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Member Name
                Text(member.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                // Member Image
                if let imageUrl = member.images?.first, let url = URL(string: imageUrl) {
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

                // Nature Types
                if let natureTypes = member.natureType?.joined(separator: ", ") {
                    Text("Nature Types: \(natureTypes)")
                        .font(.headline)
                }

//                // Personal Details
//                if let personal = member.personal {
//                    VStack(alignment: .leading, spacing: 5) {
//                        if let affiliation = personal.affiliation {
//                            Text("Affiliation: \(affiliation)")
//                        }
//                        if let classification = personal.classification {
//                            Text("Classification: \(classification)")
//                        }
//                        if let status = personal.status {
//                            Text("Status: \(status)")
//                        }
//                    }
//                }

                // Jutsu
                if let jutsu = member.jutsu?.joined(separator: ", ") {
                    Text("Jutsu: \(jutsu)")
                        .font(.headline)
                }

                // Tools
                if let tools = member.tools?.joined(separator: ", ") {
                    Text("Tools: \(tools)")
                        .font(.headline)
                }
            }
            .padding()
        }
        .navigationTitle(member.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


//#Preview {
//    KaraDetailView()
//}
