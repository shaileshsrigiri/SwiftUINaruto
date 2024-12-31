//
//  CharacterResponse.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/29/24.
//

import Foundation

struct CharacterResponse: Codable {
    let characters: [Character]
    let currentPage, pageSize, totalCharacters: Int
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let images: [String]?
    let jutsu: [String]?
    let debut: Debut?
    let uniqueTraits: [String]?
    let natureType: [String]?
    let family: Family?
    let tools: [String]?
    //let personal: Personal?
    //let rank: Rank?
    let voiceActors: VoiceActors?
}

struct Debut: Codable {
    let manga, anime, novel, movie, game, ova, appearsIn: String?
}

struct Family: Codable {
    let son: String?
    let father: String?
    let mother: String?
    let husband: String?
    let adoptiveSon: String?
    let adoptiveFather: String?
    let brother: String?
    let cousin: String?
}

struct VoiceActors: Codable {
    let japanese: [String]?
    let english: [String]?
    
    enum CodingKeys: String, CodingKey {
        case japanese
        case english
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let singleJapanese = try? container.decode(String.self, forKey: .japanese) {
            japanese = [singleJapanese]
        } else {
            japanese = try container.decodeIfPresent([String].self, forKey: .japanese)
        }
        
        if let singleEnglish = try? container.decode(String.self, forKey: .english) {
            english = [singleEnglish]
        } else {
            english = try container.decodeIfPresent([String].self, forKey: .english)
        }
    }
}


//
//// MARK: - Personel
//struct Personal: Codable {
//    //let status: String?
//    //let clan: String?
//    //let kekkeiGenkai: String?
//    //let jinchūriki: [String]?
//    let team: [String]?
//    //let occupation: [String]?
//    //let affiliation: [String]?
//
//    enum CodingKeys: String, CodingKey {
//        //case status//, clan, kekkeiGenkai, jinchūriki
//        case team//, occupation, affiliation
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)

        //status = try container.decodeIfPresent(String.self, forKey: .status)
        //clan = try container.decodeIfPresent(String.self, forKey: .clan)
        //kekkeiGenkai = try container.decodeIfPresent(String.self, forKey: .kekkeiGenkai)
        //jinchūriki = try container.decodeIfPresent([String].self, forKey: .jinchūriki)

//        // Handle single value or array for occupation
//        if let singleOccupation = try? container.decode(String.self, forKey: .occupation) {
//            occupation = [singleOccupation]
//        } else {
//            occupation = try container.decodeIfPresent([String].self, forKey: .occupation)
//        }
//
//        // Handle single value or array for affiliation
//        if let singleAffiliation = try? container.decode(String.self, forKey: .affiliation) {
//            affiliation = [singleAffiliation]
//        } else {
//            affiliation = try container.decodeIfPresent([String].self, forKey: .affiliation)
//        }
//
//        // Handle single value or array for team
//        if let singleTeam = try? container.decode(String.self, forKey: .team) {
//            team = [singleTeam]
//        } else {
//            team = try container.decodeIfPresent([String].self, forKey: .team)
//        }
//    }
//}
//
//// MARK: - Rank
//struct Rank: Codable {
//    let ninjaRank: [String: String]?
//}
//

//struct Rank: Codable {
//    let ninjaRank: [String: String]?
//
//    enum CodingKeys: String, CodingKey {
//        case ninjaRank
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        // Decode ninjaRank flexibly
//        if let dictionary = try? container.decode([String: String].self, forKey: .ninjaRank) {
//            ninjaRank = dictionary
//        } else if let singleString = try? container.decode(String.self, forKey: .ninjaRank) {
//            ninjaRank = ["Unknown": singleString] // Fallback for single strings
//        } else {
//            ninjaRank = nil // Fallback for null or missing cases
//            print("⚠️ `ninjaRank` is in an unexpected format.")
//        }
//    }
//}

