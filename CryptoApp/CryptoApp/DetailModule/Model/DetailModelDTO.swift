//
//  DetailModelDTO.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 24.12.2021.
//

import Foundation

import Foundation

// MARK: - DetailModelDTO
struct DetailModelDTO: Decodable {
    let data: [Datum]
    let timestamp: Int
}

// MARK: - Datum
struct Datum: Decodable {
    let exchangeId, baseId: String
    let quoteId: String?
    let baseSymbol: String
    let quoteSymbol: String?
    let volumeUsd24Hr: String?
    let priceUsd: String
    let volumePercent: String?
}



