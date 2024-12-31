//
//  CharacterGridItemView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/29/24.
//

import SwiftUI

struct CharacterGridItemView: View {
    let character: Character

    var body: some View {
        VStack {
            if let imageUrl = character.images?.first, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else if phase.error != nil {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                    } else {
                        ProgressView()
                            .frame(width: 150, height: 150)
                    }
                }
            }

            Text(character.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(width: 150)
        }
    }
}
