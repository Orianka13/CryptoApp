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
    
    private var data = [ListModel]()
    private var filteredData = [ListModel]()
    
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
    }
    
    
    private func getContext() -> NSManagedObjectContext {
        return self.coreDS.persistentContainer.viewContext
        
    }
    
    func loadDataNetwork() {
        self.network.loadData { [weak self] (result: Result<ModelDTO, Error>) in
            switch result {
            case .success(let model):
                let data = model.data
                data.forEach() { [weak self] item in
                    let model = ListModel(id: item.id, symbol: item.symbol,
                                          name: item.name, priceUsd: item.priceUsd,
                                          changePercent24Hr: item.changePercent24Hr)
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
