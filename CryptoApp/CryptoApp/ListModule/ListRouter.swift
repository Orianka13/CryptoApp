//
//  ListRouter.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation
import UIKit

final class ListRouter {
    
    func nextDetailModule(item: ListModel, user: AuthModel, controller: ListViewController) {
        
        let targetController = DetailAssembly.build(item: item, user: user)
        
        controller.navigationController?.pushViewController(targetController, animated: true)
    }
    
    func nextConverterModule(controller: ListViewController) {
        
        let targetController = ConvertAssembly.build()
        
        controller.navigationController?.present(targetController, animated: true)
    }
}
