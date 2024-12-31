//
//  clan.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/30/24.
//

import Foundation

struct ClanResponse: Codable {
    let clans: [Clan]
    let currentPage: Int
    let pageSize: Int
    let totalClans: Int
}

struct Clan: Codable, Identifiable {
    let id: Int
    let name: String
    let characters: [Character]
}
