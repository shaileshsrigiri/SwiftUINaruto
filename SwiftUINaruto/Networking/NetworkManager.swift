//
//  NetworkManager.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/29/24.
//


import Foundation

class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()

    private init() {}

    func fetchData<T: Decodable>(from endpoint: NarutoAPIEndpoints, responseType: T.Type) async throws -> T {
        guard let url = URL(string: endpoint.urlString) else {
            throw NetworkError.invalidURL
        }
        
        print("Fetching data from: \(url)")
        let (data, response) = try await URLSession.shared.data(from: url)
        print("Received raw JSON: \(String(data: data, encoding: .utf8) ?? "Invalid JSON")")

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        //print("Raw Data: \(String(data: data, encoding: .utf8) ?? "No data")")

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Decoding Error: \(error.localizedDescription)")
            throw NetworkError.DecodingError
        }
    }
}
