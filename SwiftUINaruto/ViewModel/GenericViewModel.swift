//
//  GenericViewModel.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//


import Foundation

@MainActor
class GenericViewModel<T: Codable & Identifiable>: ObservableObject {
    @Published var items: [T] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var currentPage: Int = 1
    @Published var totalItems: Int = 0

    private let pageSize: Int
    private let networkManager: NetworkManaging
    private let endpointGenerator: (Int, Int) -> NarutoAPIEndpoints

    init(
        pageSize: Int = 20,
        networkManager: NetworkManaging = NetworkManager.shared,
        endpointGenerator: @escaping (Int, Int) -> NarutoAPIEndpoints
    ) {
        self.pageSize = pageSize
        self.networkManager = networkManager
        self.endpointGenerator = endpointGenerator
    }

    func fetchItems(page: Int = 1) async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        do {
            let endpoint = endpointGenerator(page, pageSize)
            print("Fetching from endpoint: \(endpoint.urlString)")
            let response: GenericResponse<T> = try await networkManager.fetchData(from: endpoint, responseType: GenericResponse<T>.self)

            if page == 1 {
                items = response.items
            } else {
                items.append(contentsOf: response.items)
            }
            currentPage = response.currentPage
            totalItems = response.totalItems
        } catch {
            errorMessage = error.localizedDescription
            print("Error: \(error)")
        }

        isLoading = false
    }

    func loadMoreIfNeeded(currentItem: T) async {
        guard !isLoading, items.count < totalItems else { return }

        if let lastItem = items.last, lastItem.id == currentItem.id {
            await fetchItems(page: currentPage + 1)
        }
    }
}


struct GenericResponse<T: Decodable>: Decodable {
    let items: [T]
    let currentPage: Int
    let pageSize: Int
    let totalItems: Int

    enum CodingKeys: String, CodingKey {
        case characters
        case akatsuki
        case clans
        case kara
        case kekkeiGenkai = "kekkeigenkai"
        case tailedBeasts = "tailedBeasts"
        case teams
        case villages
        case totalCharacters = "totalCharacters"
        case totalAkatsuki = "totalMembers"
        case totalClans = "totalClans"
        case totalKara = "totalKara"
        case totalKekkeiGenkai = "totalKekkeiGenkai"
        case totalTailedBeasts = "totalTailedBeasts"
        case totalTeams = "totalTeams"
        case totalVillages = "totalVillages"
        case currentPage
        case pageSize
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode `items` from various possible keys
        if let characters = try? container.decode([T].self, forKey: .characters) {
            items = characters
        } else if let akatsuki = try? container.decode([T].self, forKey: .akatsuki) {
            items = akatsuki
        } else if let clans = try? container.decode([T].self, forKey: .clans) {
            items = clans
        } else if let kara = try? container.decode([T].self, forKey: .kara) {
            items = kara
        } else if let kekkeiGenkai = try? container.decode([T].self, forKey: .kekkeiGenkai) {
            items = kekkeiGenkai
        } else if let tailedBeasts = try? container.decode([T].self, forKey: .tailedBeasts) {
            items = tailedBeasts
        } else if let teams = try? container.decode([T].self, forKey: .teams) {
            items = teams
        } else if let villages = try? container.decode([T].self, forKey: .villages) {
            items = villages
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .characters,
                in: container,
                debugDescription: "No valid keys found for items"
            )
        }
        
        self.currentPage = try container.decode(Int.self, forKey: .currentPage)
        self.pageSize = try container.decode(Int.self, forKey: .pageSize)

        // Decode `totalItems` from various possible keys
        if let totalCharacters = try? container.decode(Int.self, forKey: .totalCharacters) {
            totalItems = totalCharacters
        } else if let totalAkatsuki = try? container.decode(Int.self, forKey: .totalAkatsuki) {
            totalItems = totalAkatsuki
        } else if let totalClans = try? container.decode(Int.self, forKey: .totalClans) {
            totalItems = totalClans
        } else if let totalKara = try? container.decode(Int.self, forKey: .totalKara) {
            totalItems = totalKara
        } else if let totalKekkeiGenkai = try? container.decode(Int.self, forKey: .totalKekkeiGenkai) {
            totalItems = totalKekkeiGenkai
        } else if let totalTailedBeasts = try? container.decode(Int.self, forKey: .totalTailedBeasts) {
            totalItems = totalTailedBeasts
        } else if let totalTeams = try? container.decode(Int.self, forKey: .totalTeams) {
            totalItems = totalTeams
        } else if let totalVillages = try? container.decode(Int.self, forKey: .totalVillages) {
            totalItems = totalVillages
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .totalCharacters,
                in: container,
                debugDescription: "No valid keys found for totalItems"
            )
        }
    }
}
