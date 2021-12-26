//
//  FilterModel.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 26.12.2021.
//

import Foundation

protocol IFilterModel {
    func getUserId() -> UUID
    func getCurrencyId() -> String
}

final class FilterModel {
    private let currencyId: String
    private let userId: UUID

    init(currencyId: String, userId: UUID) {
        self.currencyId = currencyId
        self.userId = userId
    }

    init?(currency: FilterItem) {
        self.currencyId = currency.itemId
        self.userId = currency.userId
    }
}

// MARK: IFilterModel
extension FilterModel: IFilterModel {
    func getUserId() -> UUID {
        return self.userId
    }

    func getCurrencyId() -> String {
        return self.currencyId
    }
}
