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
    
    private let router: AuthRouter
    private weak var controller: AuthViewController?
    private var view: IAuthView?
    private let coreDS = CoreDataStack()
    
    struct Dependencies {
        let router: AuthRouter
    }
    
    init(dependencies: Dependencies) {
        self.router = dependencies.router
    }
}

//MARK: Private extension

private extension AuthPresenter {
    
    func setHandlers() {
        self.view?.loginHandler = { [weak self] login, password in
            guard let login = login, login.isEmpty == false, let password = password, password.isEmpty == false else {
                self?.controller?.showAlert(message: "Введите логин и пароль")
                return
            }
            guard let user = self?.coreDS.getUser(login: login, password: password) else {
                self?.controller?.showAlert(message: "Пользователь не зарегистрирован или пароль не верен")
                return
            }
            guard let vc = self?.controller else { return }
            self?.router.next(user: user, controller: vc)
        }
        
        self.view?.registerHandler = { [weak self] login, password in
            guard let login = login, login.isEmpty == false, let password = password, password.isEmpty == false else {
                self?.controller?.showAlert(message: "Введите логин и пароль")
                return
            }
            guard self?.coreDS.getUser(login: login, password: password) == nil else {
                self?.controller?.showAlert(message: "Такой пользователь уже зарегистрирован")
                return
            }
            let newUser = AuthModel(login: login, password: password)
            self?.coreDS.saveUser(user: newUser, completion: {
                guard let vc = self?.controller else { return }
                self?.router.next(user: newUser, controller: vc)
            })
        }
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
