//
//  ListViewController.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import UIKit

protocol IListViewController: AnyObject {
    func setNavBar()
}

final class ListViewController: UIViewController {
    
    private struct Literal {
        static let navigationTitle = "CryptoList"
    }
    
    private enum Colors {
        static let mainBackgroundColor: UIColor = .black
        static let starColor: UIColor = .white
    }
    private enum Fonts {
        static let titleFont = UIFont(name: "HiraginoSans-W3", size: 16)
    }
    
    private var listView: ListView
    private var presenter: IListPresenter?
    
    struct Dependencies {
        let presenter: IListPresenter
    }
    
    init(dependencies: Dependencies) {
        self.listView = ListView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(controller: self, view: self.listView)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(listView)
        self.view.backgroundColor = Colors.mainBackgroundColor
    }
    
}

//MARK: IListViewController
extension ListViewController: IListViewController {
    
    func setNavBar(){
        self.navigationItem.title = Literal.navigationTitle
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: nil, action: nil)
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.titleFont ?? .systemFont(ofSize: 20)], for: .normal)
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = Colors.starColor
    }
}
