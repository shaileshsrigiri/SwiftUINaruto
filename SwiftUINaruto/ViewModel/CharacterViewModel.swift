//
//  CharacterViewModel.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/29/24.
//

import Foundation

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var currentPage: Int = 1
    @Published var totalCharacters: Int = 0

    private let pageSize: Int = 20
    private let networkManager: NetworkManaging

    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    // Fetch characters with pagination
    func fetchCharacters(page: Int = 1) async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        do {
            let endpoint = NarutoAPIEndpoints.allCharacters(page: page, limit: pageSize)
            let response: CharacterResponse = try await networkManager.fetchData(from: endpoint, responseType: CharacterResponse.self)

            if page == 1 {
                characters = response.characters
            } else {
                characters.append(contentsOf: response.characters)
            }
            currentPage = response.currentPage
            totalCharacters = response.totalCharacters
        } catch {
            errorMessage = error.localizedDescription
            print("Error: \(error)")
        }

        isLoading = false
    }

    func loadMoreIfNeeded(currentCharacter: Character) async {
        guard !isLoading, characters.count < totalCharacters else { return }

        if let lastCharacter = characters.last, lastCharacter.id == currentCharacter.id {
            await fetchCharacters(page: currentPage + 1)
        }
    }

    // Fetch a character by name or ID
    func fetchCharacterByNameOrID(searchTerm: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let endpoint: NarutoAPIEndpoints
            if let id = Int(searchTerm) {
                endpoint = .characterByID("\(id)")
            } else {
                endpoint = .characterByName(searchTerm)
            }

            let character: Character = try await networkManager.fetchData(from: endpoint, responseType: Character.self)
            characters = [character]
        } catch {
            errorMessage = error.localizedDescription
            print("Error: \(error)")
        }

        isLoading = false
    }
}
