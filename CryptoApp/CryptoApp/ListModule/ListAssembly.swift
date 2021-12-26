//
//  ListAssembly.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation
import UIKit

final class ListAssembly {
    
    
    static func build(user: AuthModel) -> ListViewController {
        
        let router = ListRouter()
        let network = NetworkManager()
        
        let presenter = ListPresenter(dependencies: .init(router: router, network: network, user: user))
        let controller = ListViewController(dependencies: .init(presenter: presenter))
        
        return controller
        
    }
}
