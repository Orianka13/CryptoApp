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
    
    private var tableView: ListTableView?
    private let coreDS = CoreDataStack()
    private var data = [ListModel]()
    private var router: ListRouter
    
    struct Dependencies {
        let router: ListRouter
    }
    
    init(dependencies: Dependencies) {
        self.router = dependencies.router
    }
    
}

//MARK: Private extension
private extension ListPresenter {
    func setHandlers() {
//        self.controller?.onTouchedHandler = {[weak self] name in
//
//        }
        
        
        self.tableView?.didSelectRowAtHandler = { [weak self] indexPath in
            guard let item = self?.data[indexPath.row] else { return }
          
            //let vc = EmployeeAssembly.build(companyUid: uid)
            //self?.controller?.navigationController?.pushViewController(vc, animated: true)
        }
        
        self.tableView?.numberOfRowsInSectionHandler = { [weak self] in
            return self?.data.count ?? 0
        }
        
//        self.tableView?.cellForRowAtHandler = { [weak self] indexPath in
//            let item = self?.data[indexPath.row]
//            return item?.getName() ?? Literal.itemError
//        }
        
    }
    
    
    private func getContext() -> NSManagedObjectContext {
        return self.coreDS.persistentContainer.viewContext
        
    }
}

//MARK: IListPresenter

extension ListPresenter: IListPresenter {
    
    func loadView(controller: ListViewController, view: IListView) {
        
        self.controller = controller
        self.view = view
        
        self.tableView = view.getTableView()
        self.setHandlers()
        self.controller?.setNavBar()
        
    }
}
