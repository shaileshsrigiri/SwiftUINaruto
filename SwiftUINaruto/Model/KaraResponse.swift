//
//  Kara.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/30/24.
//


import Foundation

struct KaraResponse: Codable {
    let kara: [Kara]
    let currentPage: Int
    let pageSize: Int
    let totalKara: Int
}

struct Kara: Codable, Identifiable {
    let id: Int
    let name: String
    let images: [String]?
    let jutsu: [String]?
    let debut: Debut?
    let natureType: [String]?
    let tools: [String]?
    let voiceActors: VoiceActors?
}



