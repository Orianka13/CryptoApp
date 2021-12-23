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
    
    private var coinArray = [ListModel]()
    
    struct Dependencies {
        let router: ListRouter
        let network: INetworkManager
    }
    
    init(dependencies: Dependencies) {
        self.router = dependencies.router
        self.network = dependencies.network
    }
    
}

//MARK: Private extension
private extension ListPresenter {
    func setHandlers() {
        
//        self.tableView?.didSelectRowAtHandler = { [weak self] indexPath in
//            guard let item = self?.data[indexPath.row] else { return }
//        }
        
        self.tableView?.cellForRowAtHandler = { cell, indexPath in
            let item = self.coinArray[indexPath.row]
            cell.setLabelsText(price: item.getPrice(), percent: item.getChangePecent())
            return item.getSymbol()
        }
        
        
        
        self.tableView?.numberOfRowsInSectionHandler = { [weak self] in
            return self?.coinArray.count ?? 0
        }
    }
    
    
    private func getContext() -> NSManagedObjectContext {
        return self.coreDS.persistentContainer.viewContext
        
    }
    
    func loadDataNetwork() {
        self.network.loadData { (result: Result<ModelDTO, Error>) in
            switch result {
            case .success(let model):
                let data = model.data
                data.forEach() { item in
                    let model = ListModel(id: item.id, symbol: item.symbol,
                                          name: item.name, priceUsd: item.priceUsd,
                                          changePercent24Hr: item.changePercent24Hr)
                    self.coinArray.append(model)
                    self.tableView?.reloadTableView()
                    self.setHandlers()
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
