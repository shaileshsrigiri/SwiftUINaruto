//
//  NetworkManaging.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/29/24.
//


import Foundation

protocol NetworkManaging {
    func fetchData<T: Decodable>(from endpoint: NarutoAPIEndpoints, responseType: T.Type) async throws -> T
}
