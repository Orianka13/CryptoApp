//
//  CryptoModel.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 27.12.2021.
//

import Foundation

protocol ICryptoModel {
    func getCriptoSymbol() -> [String]
    func getCriptoPrice() -> [Double]
}

class CryptoModel {
    private var criptoSymbol: [String]
    private var criptoPrice: [Double]
    
    init(criptoSymbol: [String], criptoPrice: [Double]){
        self.criptoSymbol = criptoSymbol
        self.criptoPrice = criptoPrice
    }
}

extension CryptoModel {
    func getCriptoSymbol() -> [String] {
        return self.criptoSymbol
    }
    func getCriptoPrice() -> [Double] {
        return self.criptoPrice
    }
}
