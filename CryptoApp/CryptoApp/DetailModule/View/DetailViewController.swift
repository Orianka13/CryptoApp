//
//  DetailViewController.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 24.12.2021.
//

import UIKit

protocol IDetailViewController: AnyObject {
    func setNavBar(title: String)
    var addToFavoriteHandler: (() -> Void)? { get set }
}

final class DetailViewController: UIViewController {
    
    private struct Literal {
        static let navigationTitle = "Detail"
        static let imageName = "star"
    }
    
    private enum Colors {
        static let mainBackgroundColor: UIColor = .black
        static let mainColor = UIColor(red: 103/255, green: 222/255, blue: 165/255, alpha: 1)
        static let starColor: UIColor = .white
    }
    
    var addToFavoriteHandler: (() -> Void)?
    
    private var detailView: DetailView
    private var presenter: IDetailPresenter?
    
    struct Dependencies {
        let presenter: IDetailPresenter
    }
    
    init(dependencies: Dependencies) {
        self.detailView = DetailView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(controller: self, view: self.detailView)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(detailView)
        self.view.backgroundColor = Colors.mainBackgroundColor
    }
    
    @objc private func addToFavorite(){
        self.addToFavoriteHandler?()
    }
    
}

//MARK: IDetailViewController
extension DetailViewController: IDetailViewController {
    
    func setNavBar(title: String){
        self.navigationItem.title = title
        let rightButton = UIBarButtonItem(image: UIImage(systemName: Literal.imageName), style: .plain, target: self, action: #selector(addToFavorite))
        rightButton.tintColor = Colors.starColor
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = Colors.starColor
    }
}

