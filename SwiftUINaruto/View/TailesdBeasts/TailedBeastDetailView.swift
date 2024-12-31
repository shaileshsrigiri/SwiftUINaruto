//
//  TailedBeastDetailView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct TailedBeastDetailView: View {
    let tailedBeast: TailedBeast

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Tailed Beast Name
                Text(tailedBeast.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                // Tailed Beast Image
                if let imageUrl = tailedBeast.images?.first, let url = URL(string: imageUrl) {
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

                // Nature Types
                if let natureTypes = tailedBeast.natureType {
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
                if let jutsuList = tailedBeast.jutsu {
                    Text("Jutsu:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    ForEach(jutsuList, id: \.self) { jutsu in
                        Text(jutsu)
                            .font(.body)
                            .padding(.leading, 10)
                    }
                }

                // Unique Traits
                if let uniqueTraits = tailedBeast.uniqueTraits {
                    Text("Unique Traits:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    ForEach(uniqueTraits, id: \.self) { trait in
                        Text(trait)
                            .font(.body)
                            .padding(.leading, 10)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(tailedBeast.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


//#Preview {
//    TailedBeastDetailView()
//}
