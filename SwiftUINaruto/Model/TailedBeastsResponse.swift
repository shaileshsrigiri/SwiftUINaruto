//
//  TailedBeasts.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/30/24.
//

import Foundation

import Foundation

struct TailedBeastResponse: Codable {
    let tailedBeasts: [TailedBeast]
    let currentPage: Int
    let pageSize: Int
    let totalTailedBeasts: Int
}

struct TailedBeast: Codable, Identifiable {
    let id: Int
    let name: String
    let images: [String]?
    let debut: Debut?
    let family: Family?
    let jutsu: [String]?
    let natureType: [String]?
    let uniqueTraits: [String]?
    let tools: [String]?
}


