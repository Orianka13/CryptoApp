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
    
    private enum Literal {
        static let error1 = "Введите логин и пароль"
        static let error2 = "Пользователь не зарегистрирован или пароль не верен"
        static let error3 = "Введите логин и пароль"
        static let error4 = "Такой пользователь уже зарегистрирован"
        static let questionResponse = "Зарегистрируйтесь, чтобы добавлять интересующую криптовалюту в избранное"
    }
    
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
                self?.controller?.showAlert(message: Literal.error1)
                return
            }
            guard let user = self?.coreDS.getUser(login: login, password: password) else {
                self?.controller?.showAlert(message: Literal.error2)
                return
            }
            guard let vc = self?.controller else { return }
            self?.router.next(user: user, controller: vc)
        }
        
        self.view?.registerHandler = { [weak self] login, password in
            guard let login = login, login.isEmpty == false, let password = password, password.isEmpty == false else {
                self?.controller?.showAlert(message: Literal.error3)
                return
            }
            guard self?.coreDS.getUser(login: login, password: password) == nil else {
                self?.controller?.showAlert(message: Literal.error4)
                return
            }
            let newUser = AuthModel(login: login, password: password)
            self?.coreDS.saveUser(user: newUser, completion: {
                guard let vc = self?.controller else { return }
                self?.router.next(user: newUser, controller: vc)
            })
        }
        
        self.view?.questionHandler = { [weak self] in
            self?.controller?.showAlert(message: Literal.questionResponse)
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
