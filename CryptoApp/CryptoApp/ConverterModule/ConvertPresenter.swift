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
    }
    func loadDataNetwork() {
        let url = self.network.getListUrl()
        self.network.loadData(url: url) { [weak self] (result: Result<CurrencyDTOModel, Error>) in
            switch result {
            case .success(let model):
                guard let data = model.data else { return }
                
                var currencySymbol = [String]()
                var currencyRate = [Double]()
                
                data.forEach() { item in
                    guard let symbol = item.symbol else { return }
                    guard let rate = item.rateUsd else { return }
                    let doubleRate = Double(rate) ?? 0
                    
                    currencySymbol.append(symbol)
                    currencyRate.append(doubleRate)
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
                    guard let timeStamp = model.timestamp else { return }
                    print("Загрузка закончена \(timeStamp)")
                }
            case .failure(let error):
                print("[NETWORK] error is: \(error)")
                DispatchQueue.main.async {
                    print("Загрузка закончена с ошибкой \(error.localizedDescription)")
                }
            }
        }
    }
}

//MARK: IAuthPresenter
extension ConvertPresenter: IConvertPresenter {
    
    func loadView(controller: ConvertViewController, view: IConvertView) {
        self.controller = controller
        self.view = view
        self.loadDataNetwork()
        self.setHandlers()
    }
}
