//
//  AuthPresenter.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation

protocol IAuthPresenter {
    func loadView(controller: AuthViewController, view: IAuthView)
}

final class AuthPresenter {
    
    private let model: IAuthModel
    private let router: AuthRouter
    private weak var controller: AuthViewController?
    private var view: IAuthView?
    
    struct Dependencies {
        let model: IAuthModel
        let router: AuthRouter
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
    }
}

//MARK: Private extension

private extension AuthPresenter {
    
    func setHandlers() {
        
    }
}

//MARK: IAuthPresenter
extension AuthPresenter: IAuthPresenter {
    
    func loadView(controller: AuthViewController, view: IAuthView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
}
