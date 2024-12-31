//
//  Villages.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/30/24.
//


import Foundation

struct VillageResponse: Codable {
    let villages: [Village]
    let currentPage: Int
    let pageSize: Int
    let totalVillages: Int
}

struct Village: Codable, Identifiable {
    let id: Int
    let name: String
    let characters: [Character]
}

