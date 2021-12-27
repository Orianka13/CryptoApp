//
//  CurrencyDTOModel.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 27.12.2021.
//

import Foundation


// MARK: CurrencyDTOModel
struct CurrencyDTOModel: Decodable {
    let data: [CurrencyDatum]
    let timestamp: Int
}

// MARK: Datum
struct CurrencyDatum: Decodable {
    let id, symbol: String?
    let currencySymbol: String?
    let type: String?
    let rateUsd: String?
}


