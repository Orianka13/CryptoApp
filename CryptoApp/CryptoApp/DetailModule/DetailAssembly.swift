//
//  DetailAssembly.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 24.12.2021.
//

import Foundation

final class DetailAssembly {
    
    
    static func build(item: ListModel, user: AuthModel) -> DetailViewController {
        
        let router = DetailRouter()
        let network = NetworkManager()
        
        let presenter = DetailPresenter(dependencies: .init(router: router, network: network, item: item, user: user))
        let controller = DetailViewController(dependencies: .init(presenter: presenter))
        
        return controller
        
    }
}
