//
//  DetailModel.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 24.12.2021.
//

import Foundation

protocol IDetailModel {
    func getId() -> String
    func getAveragePrice() -> String
    func getHighPrice() -> Double
    func getHighMarket() -> String
    func getLowPrice() -> Double
    func getLowMarket() -> String
    func getAvaliableAmount() -> String
    func getChangePercent() -> Double
}

final class DetailModel {
    private let id: String
    private let averagePrice: String
    private let highPrice: Double
    private let highMarket: String
    private let lowPrice: Double
    private let lowMarket: String
    private let avaliableAmount: String
    private let changePercent: Double
    
    init(item: ListModel, highPrice: Double, highMarket: String, lowPrice: Double, lowMarket: String){
        self.id = item.getName()
        self.averagePrice = item.getPrice()
        self.highPrice = highPrice
        self.highMarket = highMarket
        self.lowPrice = lowPrice
        self.lowMarket = lowMarket
        self.avaliableAmount = item.getSupply()
        self.changePercent = Double(item.getChangePecent()) ?? 0
 
    }
}

// MARK: IDetailModel
extension DetailModel: IDetailModel {
    func getId() -> String {
        return self.id
    }
    
    func getAveragePrice() -> String {
        return self.averagePrice
    }
    
    func getHighPrice() -> Double {
        return self.highPrice
    }
    
    func getHighMarket() -> String {
        return self.highMarket
    }
    
    func getLowPrice() -> Double {
        return self.lowPrice
    }
    
    func getLowMarket() -> String {
        return self.lowMarket
    }
    
    func getAvaliableAmount() -> String {
        return self.avaliableAmount
    }
    
    func getChangePercent() -> Double {
        return self.changePercent
    }
}
