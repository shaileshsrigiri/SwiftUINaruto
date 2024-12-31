//
//  CharacterListView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/29/24.
//

import SwiftUI

struct CharacterGridView: View {
    @StateObject private var viewModel = CharacterViewModel()
    @State private var searchText = ""
    
    var filteredCharacters: [Character] {
        if searchText.isEmpty {
            return viewModel.characters
        } else {
            return viewModel.characters.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                "\($0.id)".contains(searchText)
            }
        }
    }

    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredCharacters) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            CharacterGridItemView(character: character)
                        }
                        .onAppear {
                            Task {
                                await viewModel.loadMoreIfNeeded(currentCharacter: character)
                            }
                        }
                    }
                }
                .padding()
            }
            .searchable(text: $searchText, prompt: "Search by name or ID")
            .navigationTitle("Naruto Characters")
            .task {
                await viewModel.fetchCharacters()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .scaleEffect(1.5)
                }
            }
        }
    }
}


#Preview {
    CharacterGridView()
}
