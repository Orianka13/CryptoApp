//
//  ListPresenter.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation
import CoreData

protocol IListPresenter {
    func loadView(controller: ListViewController, view: IListView)
}

final class ListPresenter {
    
    private enum Literal {
        
    }
    
    private weak var controller: ListViewController?
    private var view: IListView?
    
    private var network: INetworkManager
    private var tableView: ListTableView?
    private let coreDS = CoreDataStack()
    private var router: ListRouter
    private let user: AuthModel
    
    private var data = [ListModel]()
    private var filteredData = [ListModel]()
    private var favoriteData = [ListModel]()
    
    struct Dependencies {
        let router: ListRouter
        let network: INetworkManager
        let user: AuthModel
    }
    
    init(dependencies: Dependencies) {
        self.router = dependencies.router
        self.network = dependencies.network
        self.user = dependencies.user
    }
    
}

//MARK: Private extension
private extension ListPresenter {
    func setHandlers() {
        
        self.tableView?.didSelectRowAtHandler = { [weak self] indexPath in
            guard let item = self?.filteredData[indexPath.row] else { return }
            guard let user = self?.user else { return }
            guard let controller = self?.controller else { return }
            self?.router.nextDetailModule(item: item, user: user, controller: controller)
        }
        
        self.tableView?.cellForRowAtHandler = { cell, indexPath in
            let item = self.filteredData[indexPath.row]
            cell.setLabelsText(price: item.getPrice(), percent: item.getChangePecent())
            return item.getSymbol()
        }
        
        self.tableView?.numberOfRowsInSectionHandler = { [weak self] in
            return self?.filteredData.count ?? 0
        }
        
        self.view?.searchBarHandler = { [weak self] searchText in
            guard let data = self?.data else { return }
            self?.filteredData = searchText.isEmpty ? data : data.filter({(dataItem: ListModel) -> Bool in
                let dataSymbol = dataItem.getSymbol()
                return dataSymbol.range(of: searchText, options: .caseInsensitive) != nil
            })
            self?.tableView?.reloadTableView()
        }
        
        self.view?.favoriteOnHandler = { [weak self] in
            guard let user = self?.user else { return }
            guard let filterFavoriteData = self?.coreDS.getCurrency(for: user) else { return }
            guard let data = self?.data else { return }
            
            
            self?.filteredData = data.filter({(dataItem: ListModel) -> Bool in
                let dataId = dataItem.getId()
                return filterFavoriteData.contains(where: { (itemId: FilterModel) -> Bool in
                    self?.tableView?.reloadTableView()
                    return dataId == itemId.getCurrencyId();
                })
            })
        }
        
        self.view?.allHandler = { [weak self] in
            guard let data = self?.data else { return }
            self?.filteredData = data
            self?.tableView?.reloadTableView()
        }
        self.view?.sortHandler = { [weak self] in
            self?.filteredData.sort(by: { Double($0.getPrice()) ?? 0 > Double($1.getPrice()) ?? 0 })
            self?.tableView?.reloadTableView()
        }
        
        self.view?.convertHandler = { [weak self] in
            var symbolArray = [String]()
            var priceArray = [Double]()
            self?.data.forEach { item in
                let symbol = item.getSymbol()
                let price = item.getPrice()
                let doublePrice = Double(price) ?? 0
                symbolArray.append(symbol)
                priceArray.append(doublePrice)
            }
            let cryptoModel = CryptoModel(criptoSymbol: symbolArray, criptoPrice: priceArray)
            guard let controller = self?.controller else { return }
            self?.router.nextConverterModule(controller: controller, cryptoModel: cryptoModel)
        }
        
    }
    
    
    private func getContext() -> NSManagedObjectContext {
        return self.coreDS.persistentContainer.viewContext
        
    }
    
    func loadDataNetwork() {
        let url = self.network.getListUrl()
        self.network.loadData(url: url) { [weak self] (result: Result<ModelDTO, Error>) in
            switch result {
            case .success(let model):
                guard let data = model.data else { return }
                data.forEach() { [weak self] item in
                    let itemId = item.id ?? "0"
                    let symbol = item.symbol ?? "0"
                    let name = item.name ?? "No name"
                    let price = item.priceUsd ?? "0"
                    let percent = item.changePercent24Hr ?? "0"
                    let supply = item.supply ?? "0"
                    
                    let model = ListModel(id: itemId, symbol: symbol,
                                          name: name, priceUsd: price,
                                          changePercent24Hr: percent,
                                          supply: supply)
                    self?.data.append(model)
                    self?.tableView?.reloadTableView()
                    self?.setHandlers()
                }
                guard let data = self?.data else {
                    print("No data in data")
                    return
                }
                self?.filteredData = data
                
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

//MARK: IListPresenter

extension ListPresenter: IListPresenter {
    
    func loadView(controller: ListViewController, view: IListView) {
        
        self.controller = controller
        self.view = view
        
        self.tableView = view.getTableView()
        
        self.loadDataNetwork()
        
        self.controller?.setNavBar()
        
    }
}
