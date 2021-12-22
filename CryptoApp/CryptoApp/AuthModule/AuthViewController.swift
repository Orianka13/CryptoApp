//
//  AuthViewController.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private enum Colors {
        static let mainBackgroundColor: UIColor = .black
    }
    
    private enum Metrics {
  
    }
    
    private let authView: AuthView
    private let presenter: IAuthPresenter?
    
    struct Dependencies {
        let presenter: IAuthPresenter
    }
    
    init(dependencies: Dependencies) {
        self.authView = AuthView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(controller: self, view: self.authView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(authView)
        
        self.view.backgroundColor = Colors.mainBackgroundColor
    }
}

//MARK: Private extension
private extension AuthViewController {
    

}

