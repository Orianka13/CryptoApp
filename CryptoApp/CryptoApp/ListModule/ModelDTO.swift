//
//  ModelDTO.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 23.12.2021.
//

import Foundation

struct ModelDTO: Decodable {
    let data: [DataClass]?
    let timestamp: Int?
}

struct DataClass: Decodable {
    let id, rank, symbol, name: String?
    let maxSupply: String?
    let supply, marketCapUsd, volumeUsd24Hr: String?
    let priceUsd, changePercent24Hr: String?
    let vwap24Hr: String?
}
