//
//  AuthView.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation
import UIKit

protocol IAuthView {
    
}

final class AuthView: UIView {
    
    private enum Literal {
        static let title = "Authentication"
        static let loginPlaceholder = "   Login"
        static let passwordPlaceholder = "   Password"
        static let loginButtonTitle = "LogIn"
        static let registerButtonTitle = "Register"
    }
    
    private enum Fonts {
        static let titleFont = UIFont(name: "HiraginoSans-W3", size: 30)
    }
    
    private enum Metrics {
        static let cornerRadius = CGFloat(20)
        static let labelTitleBottomSpacing = CGFloat(70)
        static let standartHeight = CGFloat(40)
        static let tfSpacing = CGFloat(30)
        static let topSpacing = CGFloat(20)
        static let buttonWidth = CGFloat(100)
    }
    
    private enum Colors {
        static let mainColor = UIColor(red: 103/255, green: 222/255, blue: 165/255, alpha: 1)
        static let tfBackgroundColor: UIColor = .white
    }
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.text = Literal.title
        label.font = Fonts.titleFont
        label.textColor = Colors.mainColor
        return label
    }()
    
    private lazy var loginField: UITextField = {
        let tf = UITextField()
        tf.placeholder = Literal.loginPlaceholder
        tf.backgroundColor = Colors.tfBackgroundColor
        tf.layer.cornerRadius = Metrics.cornerRadius
        return tf
    }()
    
    private lazy var passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = Literal.passwordPlaceholder
        tf.backgroundColor = Colors.tfBackgroundColor
        tf.layer.cornerRadius = Metrics.cornerRadius
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Literal.loginButtonTitle, for: .normal)
        button.backgroundColor = Colors.mainColor
        button.layer.cornerRadius = Metrics.cornerRadius
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle(Literal.registerButtonTitle, for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addView(){
        self.addSubview(labelTitle)
        self.addSubview(loginField)
        self.addSubview(passwordField)
        self.addSubview(loginButton)
        self.addSubview(registerButton)
    }
    
    private func setConstraint(){
        self.makeLabelTitleConstraints()
        self.makeLoginFieldConstraints()
        self.makePasswordFieldConstraints()
        self.makeLoginButtonConstraints()
        self.makeRegisterButtonConstraints()
    }
}

//MARK: - ListViewLayout

extension AuthView {
    private func makeLabelTitleConstraints() {
        self.labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = false
        self.labelTitle.bottomAnchor.constraint(equalTo: self.loginField.topAnchor, constant: -Metrics.labelTitleBottomSpacing).isActive = true
    }
    private func makeLoginFieldConstraints() {
        self.loginField.translatesAutoresizingMaskIntoConstraints = false
        self.loginField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.loginField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.tfSpacing).isActive = true
        self.loginField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.tfSpacing).isActive = true
        self.loginField.topAnchor.constraint(equalTo: self.labelTitle.bottomAnchor, constant: Metrics.topSpacing).isActive = false
        self.loginField.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
    }
    private func makePasswordFieldConstraints() {
        self.passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.tfSpacing).isActive = true
        self.passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.tfSpacing).isActive = true
        self.passwordField.topAnchor.constraint(equalTo: self.loginField.bottomAnchor, constant: Metrics.topSpacing).isActive = true
        self.passwordField.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
    }
    private func makeLoginButtonConstraints() {
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
        self.loginButton.widthAnchor.constraint(equalToConstant: Metrics.buttonWidth).isActive = true
        self.loginButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: Metrics.topSpacing).isActive = true
    }
    private func makeRegisterButtonConstraints() {
        self.registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.registerButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: Metrics.topSpacing).isActive = true
    }
}

//MARK: IAuthView
extension AuthView: IAuthView {
    
}
