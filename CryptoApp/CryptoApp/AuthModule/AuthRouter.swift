//
//  AuthRouter.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation
import UIKit

final class AuthRouter {
    
    func next(/*cars: [Car], */controller: AuthViewController) {
        
        let targetController = ListAssembly.build()
        
        controller.navigationController?.pushViewController(targetController, animated: true)
    }
}
