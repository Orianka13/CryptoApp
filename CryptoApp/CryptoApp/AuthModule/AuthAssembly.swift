//
//  AuthAssembly.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import UIKit

final class AuthAssembly {
    
    static func build() -> UIViewController {
        
        let router = AuthRouter()
        let model = AuthModel()
        
        let presenter = AuthPresenter(dependencies: .init(model: model, router: router))
        let controller = AuthViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
