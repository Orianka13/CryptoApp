//
//  DetailPresenter.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 24.12.2021.
//

import Foundation
import CoreData

protocol IDetailPresenter {
    func loadView(controller: DetailViewController, view: IDetailView)
}

final class DetailPresenter {
    
    private enum Literal {
        
    }
    
    private weak var controller: DetailViewController?
    private var view: IDetailView?
    
    private var network: INetworkManager
    private let coreDS = CoreDataStack()
    private var router: DetailRouter
    private let item: ListModel
    private var priceArray = [Double]()
    private var markets = [String]()
    
    private var data = [DetailModel]()
    
    struct Dependencies {
        let router: DetailRouter
        let network: INetworkManager
        let item: ListModel
    }
    
    init(dependencies: Dependencies) {
        self.router = dependencies.router
        self.network = dependencies.network
        self.item = dependencies.item
    }
    
}

//MARK: Private extension
private extension DetailPresenter {
    func setHandlers() {
        
    }
    
    private func getContext() -> NSManagedObjectContext {
        return self.coreDS.persistentContainer.viewContext
        
    }
    
    func loadDataNetwork() {
        let detailUrl = "https://api.coincap.io/v2/assets/\(self.item.getId())/markets?apikey=\(network.getApiKey())"
        self.network.loadData(url: detailUrl) { [weak self] (result: Result<DetailModelDTO, Error>) in
            
            switch result {
            case .success(let model):
                let data = model.data
                
                data.forEach { item in
                    guard let price = Double(item.priceUsd) else { return }
                    self?.priceArray.append(price)
                    
                    let market = item.exchangeId
                    self?.markets.append(market)
                }
                guard let maxPrice = self?.priceArray.max() else { return }
                guard let minPrice = self?.priceArray.min() else { return }
                print("MaxPrice: \(maxPrice) MInPrice: \(minPrice)")
                
                guard let maxMarket = self?.markets.randomElement() else { return }
                guard let minMarket = self?.markets.randomElement() else { return }
                
                data.forEach() { [weak self] item in
                    guard let item = self?.item else { return }
                    let model = DetailModel(item: item,
                                            highPrice: maxPrice,
                                            highMarket: maxMarket,
                                            lowPrice: minPrice,
                                            lowMarket: minMarket)
                    
                    self?.data.append(model)
                    DispatchQueue.main.async {
                        self?.view?.setAllView(averagePrice: model.getAveragePrice(),
                                               highPrice: model.getHighPrice(),
                                               highMarket: model.getHighMarket(),
                                               lowPrice: model.getLowPrice(),
                                               lowMarket: model.getLowMarket(),
                                               avaliableAmount: model.getAvaliableAmount(),
                                               changePercent: model.getChangePercent())
                    }
                    self?.setHandlers()
                }
                
                DispatchQueue.main.async {
                    print("Загрузка закончена \(model.timestamp)")
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

//MARK: IDetailPresenter

extension DetailPresenter: IDetailPresenter {
    
    func loadView(controller: DetailViewController, view: IDetailView) {
        
        self.controller = controller
        self.view = view
        
        self.loadDataNetwork()
        
        self.controller?.setNavBar(title: item.getName())
    }
}
