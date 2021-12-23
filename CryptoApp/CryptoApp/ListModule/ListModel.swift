//
//  ListModel.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation

protocol IListModel {
    func getSymbol() -> String
    func getPrice() -> String
    func getChangePecent() -> String
}

final class ListModel {
    private var id: String
    private var symbol: String
    private var name: String
    private var priceUsd: String
    private var changePercent24Hr: String
    
    init(id: String, symbol: String, name: String, priceUsd: String, changePercent24Hr: String){
        self.id = id
        self.symbol = symbol
        self.name = name
        self.priceUsd = priceUsd
        self.changePercent24Hr = changePercent24Hr
    }
}

// MARK: IListModel
extension ListModel: IListModel {
    
    func getSymbol() -> String{
        return self.symbol
    }
    func getPrice() -> String{
        return self.priceUsd
    }
    func getChangePecent() -> String{
        return self.changePercent24Hr
    }
    
    func getName() -> String{
        return self.name
    }
    
}
