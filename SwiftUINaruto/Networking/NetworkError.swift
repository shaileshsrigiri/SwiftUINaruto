//
//  NetworkError.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/29/24.
//


import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case DecodingError
}