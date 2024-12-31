//
//  KekkeiGenkai.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/30/24.
//

import Foundation

struct KekkeiGenkaiResponse: Codable {
    let kekkeigenkai: [KekkeiGenkai]
    let currentPage: Int
    let pageSize: Int
    let totalKekkeiGenkai: Int
}

struct KekkeiGenkai: Codable, Identifiable {
    let id: Int
    let name: String
    let characters: [Character]
}

