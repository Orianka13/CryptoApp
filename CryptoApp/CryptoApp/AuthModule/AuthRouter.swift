//
//  AuthRouter.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation
import UIKit

final class AuthRouter {
    
    func next(user: AuthModel, controller: AuthViewController) {
        
        let targetController = ListAssembly.build(user: user)
        
        controller.navigationController?.pushViewController(targetController, animated: true)
    }
}
