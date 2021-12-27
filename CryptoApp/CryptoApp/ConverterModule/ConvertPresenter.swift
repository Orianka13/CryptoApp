//
//  ConvertPresenter.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 26.12.2021.
//

import Foundation

protocol IConvertPresenter {
    func loadView(controller: ConvertViewController, view: IConvertView)
}

final class ConvertPresenter {
    
    private weak var controller: ConvertViewController?
    private var view: IConvertView?
    private var network: INetworkManager
    private var cryptoModel: CryptoModel
    private var data = [ConvertModel]()
    
    private var cryptoRateRow = 0
    private var currencyRateRow = 0
    
    
    struct Dependencies {
        let network: INetworkManager
        let cryptoModel: CryptoModel
    }
    
    init(dependencies: Dependencies) {
        self.network = dependencies.network
        self.cryptoModel = dependencies.cryptoModel
    }
}

//MARK: Private extension

private extension ConvertPresenter {
    
    func setHandlers() {
        self.view?.goBackHandler = {
            self.controller?.dismiss(animated: true, completion: nil)
        }
        
        self.view?.pickerTitleHandler = { [weak self] row in
            let item = self?.data.first
            guard let criptoSymbol = item?.getCriptoSymbol() else { return "0" }
            return criptoSymbol[row]
        }
        
        self.view?.pickerDidSelectHandler = { [weak self] row in
            let item = self?.data.first
            guard let criptoSymbol = item?.getCriptoSymbol() else { return }
            let selectedPoint = criptoSymbol[row]
            self?.cryptoRateRow = row
            self?.view?.setCryptoTF(title: selectedPoint)
        }
        
        self.view?.pickerCountHandler = { [weak self] in
            let item = self?.data.first
            guard let criptoSymbol = item?.getCriptoSymbol() else { return 0 }
            return criptoSymbol.count
        }
        
        self.view?.picker2TitleHandler = { [weak self] row in
            let item = self?.data.first
            guard let currencySymbol = item?.getCurrencySymbol() else { return "0" }
            return currencySymbol[row]
        }
        
        self.view?.picker2DidSelectHandler = { [weak self] row in
            let item = self?.data.first
            guard let currencySymbol = item?.getCurrencySymbol() else { return }
            let selectedPoint = currencySymbol[row]
            self?.currencyRateRow = row
            self?.view?.setCurrencyTF(title: selectedPoint)
        }
        
        self.view?.picker2CountHandler = { [weak self] in
            let item = self?.data.first
            guard let currencySymbol = item?.getCurrencySymbol() else { return 0 }
            return currencySymbol.count
        }
        
        self.view?.convertHandler = { [weak self] in
            let item = self?.data.first
            guard let currencyRateArray = item?.getCurrencyPrice() else { return }
            guard let currencyRateRow = self?.currencyRateRow else { return }
            let currencyRate = currencyRateArray[currencyRateRow]
            
            guard let cryptoRateArray = item?.getCriptoPrice() else { return }
            guard let cryptoRateRow = self?.cryptoRateRow else { return }
            let cryptoRate = cryptoRateArray[cryptoRateRow]
            
            let value = self?.view?.getConvertValue() ?? 0
            let doubleValue = Double(value)
            let convertValue = cryptoRate / currencyRate * doubleValue
            
            self?.view?.setConvertText(convertValue: convertValue)
        }
    }
    
    func loadDataNetwork() {
        let url = self.network.getConvertUrl()
        self.network.loadData(url: url) { [weak self] (result: Result<CurrencyDTOModel, Error>) in
            switch result {
            case .success(let model):
                let data = model.data
                
                var currencySymbol = [String]()
                var currencyRate = [Double]()
                
                data.forEach() { item in
                    if item.type == "fiat" {
                        guard let symbol = item.symbol else { return }
                        guard let rate = item.rateUsd else {
                            return }
                        let doubleRate = Double(rate) ?? 0
                        
                        currencySymbol.append(symbol)
                        currencyRate.append(doubleRate)
                    }
                }
                
                guard let cryptoSymbol = self?.cryptoModel.getCriptoSymbol() else { return }
                guard let cryptoPrice = self?.cryptoModel.getCriptoPrice() else { return }
                
                let convertModel = ConvertModel(criptoSymbol: cryptoSymbol,
                                                criptoPrice: cryptoPrice,
                                                currencySymbol: currencySymbol,
                                                currencyPrice: currencyRate)
                
                self?.data.append(convertModel)
                
                self?.setHandlers()
                
                DispatchQueue.main.async {
                    self?.view?.setSymbolTitle(currency: currencySymbol.first ?? "No",
                                               crypto: cryptoSymbol.first ?? "No")
                    let timeStamp = model.timestamp
                    print("Загрузка закончена \(timeStamp)")
                }
            case .failure(let error):
                print("[NETWORK] error is: \(error)")
                DispatchQueue.main.async {
                    self?.controller?.showAlert(message: "Загрузка закончена с ошибкой \(error.localizedDescription)")
                }
            }
        }
    }
}

//MARK: IConvertPresenter
extension ConvertPresenter: IConvertPresenter {
    
    func loadView(controller: ConvertViewController, view: IConvertView) {
        self.controller = controller
        self.view = view
        self.loadDataNetwork()
        self.setHandlers()
    }
}
