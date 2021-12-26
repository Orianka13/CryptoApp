//
//  ConvertView.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 26.12.2021.
//

import Foundation
import UIKit

protocol IConvertView {
    var goBackHandler: (() -> Void)? { get set }
    var showPickerCryptoHandler: (() -> Void)? { get set }
    var showPickerCurrencyHandler: (() -> Void)? { get set }
    var convertHandler: (() -> Void)? { get set }
}

final class ConvertView: UIView {
    
    private enum Literal {
        static let closeImageName = "xmark"
        static let fromLabel = "From"
        static let toLabel = "To"
        static let buttonTitle = "Convert"
    }
    
    private enum Fonts {
        static let textFont = UIFont(name: "HiraginoSans-W3", size: 20)
        static let labelTextFont = UIFont(name: "HiraginoSans-W3", size: 17)
        
    }
    
    private enum Metrics {
        static let cornerRadius = CGFloat(20)
        static let bigTopSpacing = CGFloat(40)
        static let smallTopSpacing = CGFloat(10)
        static let standartHeight = CGFloat(40)
        static let buttonTopSpacing = CGFloat(60)
        static let standartSpacing = CGFloat(20)
        static let buttonWidth = CGFloat(100)
        static let minSpacing = CGFloat(1)
        static let smallWidth = CGFloat(50)
        static let bigWidth = CGFloat(100)
    }
    
    private enum Colors {
        static let tintColor: UIColor = .white
        static let mainColor = UIColor(red: 103/255, green: 222/255, blue: 165/255, alpha: 1)
        static let textColor: UIColor = .black
    }
    
    private lazy var fromLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.fromLabel
        label.font = Fonts.labelTextFont
        label.textColor = Colors.tintColor
        return label
    }()
    
    private lazy var toLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.toLabel
        label.font = Fonts.labelTextFont
        label.textColor = Colors.tintColor
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: Literal.closeImageName), for: .normal)
        closeButton.addTarget(self, action: #selector(goBackButton), for: .touchUpInside)
        closeButton.tintColor = Colors.tintColor
        return closeButton
    }()
    
    private lazy var chooseCriptoTF: UITextField = {
        let tf = UITextField()
        tf.addTarget(self, action: #selector(showPickerView), for: .touchUpInside)
        tf.text = "BTC"
        tf.textColor = Colors.mainColor
        tf.font = Fonts.textFont
        return tf
    }()
    
    private lazy var setAmountCriptoTF: UITextField = {
        let tf = UITextField()
        tf.text = "123456"
        tf.textColor = Colors.textColor
        tf.backgroundColor = Colors.tintColor
        tf.layer.cornerRadius = Metrics.cornerRadius
        tf.font = Fonts.labelTextFont
        return tf
    }()
    
    private lazy var chooseCurrencyTF: UITextField = {
        let tf = UITextField()
        tf.addTarget(self, action: #selector(showCurrencyPickerView), for: .touchUpInside)
        tf.text = "RUB"
        tf.textColor = Colors.mainColor
        tf.font = Fonts.textFont
        return tf
    }()
    
    private lazy var setAmountCurrencyTF: UITextField = {
        let tf = UITextField()
        tf.text = "456 7899"
        tf.textColor = Colors.textColor
        tf.backgroundColor = Colors.tintColor
        tf.layer.cornerRadius = Metrics.cornerRadius
        tf.font = Fonts.labelTextFont
        return tf
    }()
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private lazy var convertButton: UIButton = {
        let button = UIButton()
        button.setTitle(Literal.buttonTitle, for: .normal)
        button.backgroundColor = Colors.mainColor
        button.layer.cornerRadius = Metrics.cornerRadius
        button.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var goBackHandler: (() -> Void)?
    var showPickerCryptoHandler: (() -> Void)?
    var showPickerCurrencyHandler: (() -> Void)?
    var convertHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addView(){
        self.addSubview(closeButton)
        
        self.addSubview(chooseCriptoTF)
        self.addSubview(setAmountCriptoTF)
        self.addSubview(chooseCurrencyTF)
        self.addSubview(setAmountCurrencyTF)
        
        self.addSubview(fromLabel)
        self.addSubview(toLabel)
        
        self.addSubview(convertButton)
    }
    
    private func setConstraint(){
        
        self.makeCloseButtonConstraints()
        
        self.makeFromLabelConstraints()
        self.makeChooseCriptoTFConstraints()
        self.makeSetAmountCriptoTFConstraints()
        self.makeToLabelConstraints()
        self.makeChooseCurrencyTFConstraints()
        self.makeSetAmountCurrencyTFConstraints()
        self.makeConvertButtonConstraint()
    }
}

private extension ConvertView {
    @objc func goBackButton() {
        self.goBackHandler?()
    }
    
    @objc func showPickerView() {
        self.showPickerCryptoHandler?()
    }
    
    @objc func showCurrencyPickerView() {
        self.showPickerCurrencyHandler?()
    }
    
    @objc func convertButtonTapped() {
        self.convertHandler?()
    }
}

//MARK: - ListViewLayout

private extension ConvertView {
    
    private func makeCloseButtonConstraints() {
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.standartSpacing).isActive = true
        self.closeButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.closeButton.widthAnchor.constraint(equalToConstant: Metrics.standartSpacing).isActive = true
        self.closeButton.heightAnchor.constraint(equalToConstant: Metrics.standartSpacing).isActive = true
    }
    
    private func makeFromLabelConstraints() {
        self.fromLabel.translatesAutoresizingMaskIntoConstraints = false
        self.fromLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: Metrics.bigTopSpacing).isActive = true
        self.fromLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.fromLabel.widthAnchor.constraint(equalToConstant: Metrics.smallWidth).isActive = true
    }
    
    private func makeChooseCriptoTFConstraints() {
        self.chooseCriptoTF.translatesAutoresizingMaskIntoConstraints = false
        self.chooseCriptoTF.topAnchor.constraint(equalTo: self.fromLabel.bottomAnchor, constant: Metrics.smallTopSpacing).isActive = true
        self.chooseCriptoTF.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.chooseCriptoTF.widthAnchor.constraint(equalToConstant: Metrics.bigWidth).isActive = true
        self.chooseCriptoTF.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
        
    }
    
    private func makeSetAmountCriptoTFConstraints() {
        self.setAmountCriptoTF.translatesAutoresizingMaskIntoConstraints = false
        self.setAmountCriptoTF.topAnchor.constraint(equalTo: self.fromLabel.bottomAnchor, constant: Metrics.smallTopSpacing).isActive = true
        self.setAmountCriptoTF.leadingAnchor.constraint(equalTo: self.chooseCriptoTF.trailingAnchor, constant: Metrics.minSpacing).isActive = true
        self.setAmountCriptoTF.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.setAmountCriptoTF.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
        
    }
    
    private func makeToLabelConstraints() {
        self.toLabel.translatesAutoresizingMaskIntoConstraints = false
        self.toLabel.topAnchor.constraint(equalTo: self.chooseCriptoTF.bottomAnchor, constant: Metrics.bigTopSpacing).isActive = true
        self.toLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.toLabel.widthAnchor.constraint(equalToConstant: Metrics.smallWidth).isActive = true
    }
    
    private func makeChooseCurrencyTFConstraints() {
        self.chooseCurrencyTF.translatesAutoresizingMaskIntoConstraints = false
        self.chooseCurrencyTF.topAnchor.constraint(equalTo: self.toLabel.bottomAnchor, constant: Metrics.smallTopSpacing).isActive = true
        self.chooseCurrencyTF.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.chooseCurrencyTF.widthAnchor.constraint(equalToConstant: Metrics.bigWidth).isActive = true
        self.chooseCurrencyTF.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
    }
    
    private func makeSetAmountCurrencyTFConstraints() {
        self.setAmountCurrencyTF.translatesAutoresizingMaskIntoConstraints = false
        self.setAmountCurrencyTF.topAnchor.constraint(equalTo: self.toLabel.bottomAnchor, constant: Metrics.smallTopSpacing).isActive = true
        self.setAmountCurrencyTF.leadingAnchor.constraint(equalTo: self.chooseCurrencyTF.trailingAnchor, constant: Metrics.minSpacing).isActive = true
        self.setAmountCurrencyTF.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.setAmountCurrencyTF.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
    }
    
    private func makeConvertButtonConstraint() {
        self.convertButton.translatesAutoresizingMaskIntoConstraints = false
        self.convertButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.convertButton.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
        self.convertButton.widthAnchor.constraint(equalToConstant: Metrics.buttonWidth).isActive = true
        self.convertButton.topAnchor.constraint(equalTo: self.setAmountCurrencyTF.bottomAnchor, constant: Metrics.buttonTopSpacing).isActive = true
    }
    
}

//MARK: IAuthView
extension ConvertView: IConvertView {
    
}
