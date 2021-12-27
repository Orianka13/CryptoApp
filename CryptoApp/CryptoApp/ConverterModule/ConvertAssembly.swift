//
//  ConvertAssembly.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 26.12.2021.
//

import UIKit

final class ConvertAssembly {
    
    static func build(cryptoModel: CryptoModel) -> UIViewController {
        
        let network = NetworkManager()
        
        let presenter = ConvertPresenter(dependencies: .init(network: network, cryptoModel: cryptoModel))
        let controller = ConvertViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
