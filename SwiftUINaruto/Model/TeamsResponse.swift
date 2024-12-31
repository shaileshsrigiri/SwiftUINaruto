//
//  Teams.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/30/24.
//

import Foundation

struct TeamResponse: Codable {
    let teams: [Team]
    let currentPage: Int
    let pageSize: Int
    let totalTeams: Int
}

struct Team: Codable, Identifiable {
    let id: Int
    let name: String
    let characters: [Character]
}


