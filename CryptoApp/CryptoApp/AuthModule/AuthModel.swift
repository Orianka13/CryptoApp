//
//  AuthModel.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation

protocol IAuthModel {
    func getUid() -> UUID
    func getLogin() -> String
    func getPassword() -> String
}

final class AuthModel {
    private let uid: UUID
    private let login: String
    private let password: String
    
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
    func getUid() -> UUID {
        return self.uid
    }
    
    func getLogin() -> String {
        return self.login
    }
    
    func getPassword() -> String {
        return self.password
    }
}
