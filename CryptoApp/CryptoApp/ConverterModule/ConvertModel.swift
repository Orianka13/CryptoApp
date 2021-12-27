//
//  ConvertModel.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 26.12.2021.
//

import Foundation

protocol IConvertModel {
    func getCriptoSymbol() -> [String]
    func getCriptoPrice() -> [Double]
    func getCurrencySymbol() -> [String]
    func getCurrencyPrice() -> [Double]
}

final class ConvertModel {
    private let criptoSymbol: [String]
    private let criptoPrice: [Double]
    private let currencySymbol: [String]
    private let currencyPrice: [Double]
    
    init(criptoSymbol: [String], criptoPrice: [Double], currencySymbol: [String], currencyPrice: [Double]) {
        self.criptoSymbol = criptoSymbol
        self.criptoPrice = criptoPrice
        self.currencySymbol = currencySymbol
        self.currencyPrice = currencyPrice
    }
}

// MARK: IConvertModel
extension ConvertModel: IConvertModel {
    func getCriptoSymbol() -> [String] {
        return self.criptoSymbol
    }
    
    func getCriptoPrice() -> [Double] {
        return self.criptoPrice
    }
    
    func getCurrencySymbol() -> [String] {
        return self.currencySymbol
    }
    
    func getCurrencyPrice() -> [Double] {
        return self.currencyPrice
    }
}

