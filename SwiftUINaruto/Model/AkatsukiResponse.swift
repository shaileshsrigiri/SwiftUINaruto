//
//  Akatsuki.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/30/24.
//

import Foundation

struct Akatsuki: Codable, Identifiable {
    let id: Int
    let name: String
    let images: [String]?
    let jutsu: [String]?
    let debut: Debut?
    let uniqueTraits: [String]?
    let natureType: [String]?
    let family: Family?
    let tools: [String]?
    let voiceActors: VoiceActors?
}

struct AkatsukiResponse: Codable {
    let akatsuki: [Akatsuki]
    let currentPage: Int
    let pageSize: Int
    let totalMembers: Int

    enum CodingKeys: String, CodingKey {
        case akatsuki
        case currentPage
        case pageSize
        case totalMembers = "totalMembers"
    }
}

