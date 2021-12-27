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
    var pickerTitleHandler: ((Int) -> String)? { get set }
    var pickerDidSelectHandler: ((Int) -> Void)? { get set }
    func setCryptoTF(title: String)
    var pickerCountHandler: (() -> Int)? { get set }
    
    var picker2TitleHandler: ((Int) -> String)? { get set }
    var picker2DidSelectHandler: ((Int) -> Void)? { get set }
    func setCurrencyTF(title: String)
    var picker2CountHandler: (() -> Int)? { get set }
    func getConvertValue() -> Double
    func setConvertText(convertValue: Double)
    func setSymbolTitle(currency: String, crypto: String)
}

final class ConvertView: UIView {
    
    private enum Literal {
        static let closeImageName = "xmark"
        static let fromLabel = "From"
        static let toLabel = "To"
        static let buttonTitle = "Convert"
        static let arrowImage = "chevron.down"
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
        static let bigWidth = CGFloat(50)
        static let topSpacing = CGFloat(70)
    }
    
    private enum Colors {
        static let tintColor: UIColor = .white
        static let mainColor = UIColor(red: 103/255, green: 222/255, blue: 165/255, alpha: 1)
        static let textColor: UIColor = .black
    }
    
    private lazy var arrow1Image: UIImageView = {
        let image = UIImage(systemName: Literal.arrowImage)
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = Colors.mainColor
        return imageView
    }()
    private lazy var arrow2Image: UIImageView = {
        let image = UIImage(systemName: Literal.arrowImage)
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = Colors.mainColor
        return imageView
    }()
    
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
        tf.textColor = Colors.mainColor
        tf.font = Fonts.textFont
        return tf
    }()
    
    private lazy var setAmountCriptoTF: UITextField = {
        let tf = UITextField()
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: tf.frame.height))
        tf.leftViewMode = .always
        tf.placeholder = "Enter amount"
        tf.textColor = Colors.textColor
        tf.backgroundColor = Colors.tintColor
        tf.layer.cornerRadius = Metrics.cornerRadius
        tf.font = Fonts.labelTextFont
        return tf
    }()
    
    private lazy var chooseCurrencyTF: UITextField = {
        let tf = UITextField()
        tf.addTarget(self, action: #selector(showCurrencyPickerView), for: .touchUpInside)
        tf.textColor = Colors.mainColor
        tf.font = Fonts.textFont
        return tf
    }()
    
    private lazy var setAmountCurrencyTF: UITextField = {
        let tf = UITextField()
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: tf.frame.height))
        tf.leftViewMode = .always
        tf.textColor = Colors.textColor
        tf.backgroundColor = Colors.tintColor
        tf.layer.cornerRadius = Metrics.cornerRadius
        tf.font = Fonts.labelTextFont
        return tf
    }()
    
    private lazy var convertButton: UIButton = {
        let button = UIButton()
        button.setTitle(Literal.buttonTitle, for: .normal)
        button.backgroundColor = Colors.mainColor
        button.layer.cornerRadius = Metrics.cornerRadius
        button.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private(set) var elementPicker1 = UIPickerView()
    private(set) var elementPicker2 = UIPickerView()
    
    var goBackHandler: (() -> Void)?
    var showPickerCryptoHandler: (() -> Void)?
    var showPickerCurrencyHandler: (() -> Void)?
    var convertHandler: (() -> Void)?
    var pickerTitleHandler: ((Int) -> String)?
    var pickerDidSelectHandler: ((Int) -> Void)?
    var pickerCountHandler: (() -> Int)?
    
    var picker2TitleHandler: ((Int) -> String)?
    var picker2DidSelectHandler: ((Int) -> Void)?
    var picker2CountHandler: (() -> Int)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setConstraint()
        self.choicePoint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: Privare extension

private extension ConvertView {
    func addView(){
        self.addSubview(closeButton)
        
        self.addSubview(chooseCriptoTF)
        self.addSubview(setAmountCriptoTF)
        self.addSubview(chooseCurrencyTF)
        self.addSubview(setAmountCurrencyTF)
        
        self.addSubview(fromLabel)
        self.addSubview(toLabel)
        
        self.addSubview(convertButton)
        
        self.addSubview(arrow1Image)
        self.addSubview(arrow2Image)
    }
    
    func setConstraint(){
        self.makeCloseButtonConstraints()
        self.makeFromLabelConstraints()
        self.makeChooseCriptoTFConstraints()
        self.makeSetAmountCriptoTFConstraints()
        self.makeToLabelConstraints()
        self.makeChooseCurrencyTFConstraints()
        self.makeSetAmountCurrencyTFConstraints()
        self.makeConvertButtonConstraint()
        self.makeArrow1Constraints()
        self.makeArrow2Constraints()
    }
    
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
    
    func choicePoint() {
        self.elementPicker1.delegate = self
        self.elementPicker1.dataSource = self
        self.chooseCriptoTF.inputView = self.elementPicker1
        self.elementPicker1.tag = 1
        self.elementPicker1.backgroundColor = .white
        
        self.elementPicker2.delegate = self
        self.elementPicker2.dataSource = self
        self.chooseCurrencyTF.inputView = self.elementPicker2
        self.elementPicker2.tag = 2
        self.elementPicker2.backgroundColor = .white
    }
}

//MARK: - ConvertViewLayout

private extension ConvertView {
    
    func makeCloseButtonConstraints() {
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.standartSpacing).isActive = true
        self.closeButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.closeButton.widthAnchor.constraint(equalToConstant: Metrics.standartSpacing).isActive = true
        self.closeButton.heightAnchor.constraint(equalToConstant: Metrics.standartSpacing).isActive = true
    }
    
    func makeFromLabelConstraints() {
        self.fromLabel.translatesAutoresizingMaskIntoConstraints = false
        self.fromLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: Metrics.topSpacing).isActive = true
        self.fromLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.fromLabel.widthAnchor.constraint(equalToConstant: Metrics.smallWidth).isActive = true
    }
    
    func makeChooseCriptoTFConstraints() {
        self.chooseCriptoTF.translatesAutoresizingMaskIntoConstraints = false
        self.chooseCriptoTF.topAnchor.constraint(equalTo: self.fromLabel.bottomAnchor, constant: Metrics.smallTopSpacing).isActive = true
        self.chooseCriptoTF.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.chooseCriptoTF.widthAnchor.constraint(equalToConstant: Metrics.bigWidth).isActive = true
        self.chooseCriptoTF.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
        
    }
    
    func makeArrow1Constraints() {
        self.arrow1Image.translatesAutoresizingMaskIntoConstraints = false
        self.arrow1Image.leadingAnchor.constraint(equalTo: self.chooseCriptoTF.trailingAnchor, constant: Metrics.minSpacing).isActive = true
        self.arrow1Image.topAnchor.constraint(equalTo: self.fromLabel.bottomAnchor, constant: Metrics.standartSpacing).isActive = true
        self.arrow1Image.widthAnchor.constraint(equalToConstant: Metrics.standartSpacing).isActive = true
        self.arrow1Image.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = false
    }
    
    func makeSetAmountCriptoTFConstraints() {
        self.setAmountCriptoTF.translatesAutoresizingMaskIntoConstraints = false
        self.setAmountCriptoTF.topAnchor.constraint(equalTo: self.fromLabel.bottomAnchor, constant: Metrics.smallTopSpacing).isActive = true
        self.setAmountCriptoTF.leadingAnchor.constraint(equalTo: self.arrow1Image.trailingAnchor, constant: Metrics.smallTopSpacing).isActive = true
        self.setAmountCriptoTF.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.setAmountCriptoTF.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
        
    }
    
    func makeToLabelConstraints() {
        self.toLabel.translatesAutoresizingMaskIntoConstraints = false
        self.toLabel.topAnchor.constraint(equalTo: self.chooseCriptoTF.bottomAnchor, constant: Metrics.bigTopSpacing).isActive = true
        self.toLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.toLabel.widthAnchor.constraint(equalToConstant: Metrics.smallWidth).isActive = true
    }
    
    func makeChooseCurrencyTFConstraints() {
        self.chooseCurrencyTF.translatesAutoresizingMaskIntoConstraints = false
        self.chooseCurrencyTF.topAnchor.constraint(equalTo: self.toLabel.bottomAnchor, constant: Metrics.smallTopSpacing).isActive = true
        self.chooseCurrencyTF.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.chooseCurrencyTF.widthAnchor.constraint(equalToConstant: Metrics.bigWidth).isActive = true
        self.chooseCurrencyTF.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
    }
    
    func makeArrow2Constraints() {
        self.arrow2Image.translatesAutoresizingMaskIntoConstraints = false
        self.arrow2Image.leadingAnchor.constraint(equalTo: self.chooseCurrencyTF.trailingAnchor, constant: Metrics.minSpacing).isActive = true
        self.arrow2Image.topAnchor.constraint(equalTo: self.toLabel.bottomAnchor, constant: Metrics.standartSpacing).isActive = true
        self.arrow2Image.widthAnchor.constraint(equalToConstant: Metrics.standartSpacing).isActive = true
    }
    
    func makeSetAmountCurrencyTFConstraints() {
        self.setAmountCurrencyTF.translatesAutoresizingMaskIntoConstraints = false
        self.setAmountCurrencyTF.topAnchor.constraint(equalTo: self.toLabel.bottomAnchor, constant: Metrics.smallTopSpacing).isActive = true
        self.setAmountCurrencyTF.leadingAnchor.constraint(equalTo: self.arrow2Image.trailingAnchor, constant: Metrics.smallTopSpacing).isActive = true
        self.setAmountCurrencyTF.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.setAmountCurrencyTF.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
    }
    
    func makeConvertButtonConstraint() {
        self.convertButton.translatesAutoresizingMaskIntoConstraints = false
        self.convertButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.convertButton.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
        self.convertButton.widthAnchor.constraint(equalToConstant: Metrics.buttonWidth).isActive = true
        self.convertButton.topAnchor.constraint(equalTo: self.setAmountCurrencyTF.bottomAnchor, constant: Metrics.buttonTopSpacing).isActive = true
    }
}

//MARK: IAuthView
extension ConvertView: IConvertView {
    func setSymbolTitle(currency: String, crypto: String) {
        self.chooseCriptoTF.text = crypto
        self.chooseCurrencyTF.text = currency
    }
    
    func setConvertText(convertValue: Double) {
        self.setAmountCurrencyTF.text = String(format: "%.2f", convertValue)
    }
    
    func getConvertValue() -> Double {
        let text = self.setAmountCriptoTF.text ?? "0"
        let doubleText = Double(text) ?? 0
        return doubleText
    }
    
    func setCryptoTF(title: String) {
        self.chooseCriptoTF.text = title
    }
    
    func setCurrencyTF(title: String) {
        self.chooseCurrencyTF.text = title
    }
}
