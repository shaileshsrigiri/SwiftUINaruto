//
//  NarutoAPIEndpoints.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/29/24.
//

import Foundation

enum NarutoAPIEndpoints {
    static let baseURL = "https://narutodb.xyz/api"

    case allCharacters(page: Int, limit: Int)
    case characterByID(String)
    case characterByName(String)
    
    case allClans(page: Int, limit: Int)
    case clanByID(String)
    case clanByName(String)
    
    case allKara(page: Int, limit: Int)
    case karaByID(String)
    case karaByName(String)

    case allKekkeiGenkai(page: Int, limit: Int)
    case kekkeiGenkaiByID(String)
    case kekkeiGenkaiByName(String)

    case allTailedBeasts(page: Int, limit: Int)
    case tailedBeastByID(String)
    case tailedBeastByName(String)

    case allTeams(page: Int, limit: Int)
    case teamByID(String)
    case teamByName(String)

    case allVillages(page: Int, limit: Int)
    case villageByID(String)
    case villageByName(String)

    case allAkatsuki(page: Int, limit: Int)
    case akatsukiByID(String)
    case akatsukiByName(String)


    var urlString: String {
        switch self {
        case .allCharacters(let page, let limit):
            return "\(NarutoAPIEndpoints.baseURL)/character?page=\(page)&limit=\(limit)"
        case .characterByID(let id):
            return "\(NarutoAPIEndpoints.baseURL)/character/\(id)"
        case .characterByName(let name):
            return "\(NarutoAPIEndpoints.baseURL)/character/search?name=\(name)"
        case .allClans(let page, let limit):
            return "\(NarutoAPIEndpoints.baseURL)/clan?page=\(page)&limit=\(limit)"
        case .clanByID(let id):
            return "\(NarutoAPIEndpoints.baseURL)/clan/\(id)"
        case .clanByName(let name):
            return "\(NarutoAPIEndpoints.baseURL)/clan/search?name=\(name)"
        case .allKara(let page, let limit):
            return "\(NarutoAPIEndpoints.baseURL)/kara?page=\(page)&limit=\(limit)"
        case .karaByID(let id):
            return "\(NarutoAPIEndpoints.baseURL)/kara/\(id)"
        case .karaByName(let name):
            return "\(NarutoAPIEndpoints.baseURL)/kara/search?name=\(name)"
        case .allKekkeiGenkai(let page, let limit):
            return "\(NarutoAPIEndpoints.baseURL)/kekkei-genkai?page=\(page)&limit=\(limit)"
        case .kekkeiGenkaiByID(let id):
            return "\(NarutoAPIEndpoints.baseURL)/kekkei-genkai/\(id)"
        case .kekkeiGenkaiByName(let name):
            return "\(NarutoAPIEndpoints.baseURL)/kekkei-genkai/search?name=\(name)"
        case .allTailedBeasts(let page, let limit):
            return "\(NarutoAPIEndpoints.baseURL)/tailed-beast?page=\(page)&limit=\(limit)"
        case .tailedBeastByID(let id):
            return "\(NarutoAPIEndpoints.baseURL)/tailed-beast/\(id)"
        case .tailedBeastByName(let name):
            return "\(NarutoAPIEndpoints.baseURL)/tailed-beast/search?name=\(name)"
        case .allTeams(let page, let limit):
            return "\(NarutoAPIEndpoints.baseURL)/team?page=\(page)&limit=\(limit)"
        case .teamByID(let id):
            return "\(NarutoAPIEndpoints.baseURL)/team/\(id)"
        case .teamByName(let name):
            return "\(NarutoAPIEndpoints.baseURL)/team/search?name=\(name)"
        case .allVillages(let page, let limit):
            return "\(NarutoAPIEndpoints.baseURL)/village?page=\(page)&limit=\(limit)"
        case .villageByID(let id):
            return "\(NarutoAPIEndpoints.baseURL)/village/\(id)"
        case .villageByName(let name):
            return "\(NarutoAPIEndpoints.baseURL)/village/search?name=\(name)"
        case .allAkatsuki(let page, let limit):
            return "\(NarutoAPIEndpoints.baseURL)/akatsuki?page=\(page)&limit=\(limit)"
        case .akatsukiByID(let id):
            return "\(NarutoAPIEndpoints.baseURL)/akatsuki/\(id)"
        case .akatsukiByName(let name):
            return "\(NarutoAPIEndpoints.baseURL)/akatsuki/search?name=\(name)"
        }
        
    }
    var urlRequest: URLRequest {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        return URLRequest(url: url)
    }
}
