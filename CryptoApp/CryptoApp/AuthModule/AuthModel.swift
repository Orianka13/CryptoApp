//
//  AuthModel.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation

protocol IAuthModel {
   
}

final class AuthModel {
    let uid: UUID
    let login: String
    let password: String

    init(login: String, password: String) {
        self.uid = UUID()
        self.login = login
        self.password = password
    }

    init?(user: User) {
        self.uid = user.uid
        self.login = user.login
        self.password = user.password
    }
   
}

// MARK: IAuthModel
extension AuthModel: IAuthModel {
    
   
    
}
