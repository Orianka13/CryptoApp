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
    
    private var data = [DetailModel]()
    
    struct Dependencies {
        let router: DetailRouter
        let network: INetworkManager
    }
    
    init(dependencies: Dependencies) {
        self.router = dependencies.router
        self.network = dependencies.network
        
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
//        self.network.loadData { [weak self] (result: Result<DetailModelDTO, Error>) in
//            switch result {
//            case .success(let model):
//                let data = model.data
//                data.forEach() { [weak self] item in
//                    let model = DetailModel()
//
//                    self?.data.append(model)
//                    self?.tableView?.reloadTableView()
//                    self?.setHandlers()
//                }
//
//                DispatchQueue.main.async {
//                    print("Загрузка закончена \(model.timestamp)")
//                }
//            case .failure(let error):
//                print("[NETWORK] error is: \(error)")
//                DispatchQueue.main.async {
//                    print("Загрузка закончена с ошибкой \(error.localizedDescription)")
//                }
//            }
//        }
    }
}

//MARK: IDetailPresenter

extension DetailPresenter: IDetailPresenter {
    
    func loadView(controller: DetailViewController, view: IDetailView) {
        
        self.controller = controller
        self.view = view
        
        self.loadDataNetwork()
        
        self.controller?.setNavBar()
    }
}
