//
//  ConvertAssembly.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 26.12.2021.
//

import UIKit

final class ConvertAssembly {
    
    static func build() -> UIViewController {
        
        let presenter = ConvertPresenter()
        let controller = ConvertViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
