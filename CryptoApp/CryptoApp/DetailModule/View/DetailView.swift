//
//  DetailView.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 24.12.2021.
//

import UIKit

protocol IDetailView {
    func setAllView(averagePrice: String, highPrice: Double,
                    highMarket: String, lowPrice: Double,
                    lowMarket: String, avaliableAmount: String,
                    changePercent: Double)
}

final class DetailView: UIView {
    
    private enum Literal {
        static let downArrow = "arrow.down"
        static let upArrow = "arrow.up"
        static let avPrice = "Average price: "
        static let highPrice = "High price: "
        static let lowPrice = "Low price: "
        static let avaliable = "Avaliable: "
        static let changePercent = "Change percent: "
    }
    
    private enum Metrics {
        static let standartSpacing = CGFloat(20)
        static let minimalSpacing = CGFloat(5)
        static let lineHeight = CGFloat(2)
        static let normalTopSpacing = CGFloat(40)
        static let minimumTopSpacing = CGFloat(10)
        static let minWidth = CGFloat(100)
        static let maxWidth = CGFloat(150)
        static let avaliableAmountWidth = CGFloat(230)
    }
    
    private enum Fonts {
        static let textFont = UIFont(name: "HiraginoSans-W3", size: 20)
        static let lowTextFont = UIFont(name: "HiraginoSans-W3", size: 15)
        static let soLowTextFont = UIFont(name: "HiraginoSans-W3", size: 12)
    }
    
    private enum Colors {
        static let textColor: UIColor = .white
        static let mainColor = UIColor(red: 103/255, green: 222/255, blue: 165/255, alpha: 1)
        static let redColor: UIColor = .systemRed
    }
    
    private lazy var avaregePriceLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.avPrice
        label.font = Fonts.textFont
        label.textColor = Colors.textColor
        return label
    }()
    
    private lazy var avaregePrice: UILabel = {
        let label = UILabel()
        label.font = Fonts.textFont
        label.textColor = Colors.textColor
        label.textAlignment = .right
        return label
    }()
    
    
    private lazy var highPriceLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.highPrice
        label.font = Fonts.lowTextFont
        label.textColor = Colors.textColor
        return label
    }()
    
    private lazy var highPrice: UILabel = {
        let label = UILabel()
        label.font = Fonts.lowTextFont
        label.textColor = Colors.textColor
        label.textAlignment = .right
        return label
    }()
    
    private lazy var highMarketLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.soLowTextFont
        label.textColor = Colors.textColor
        label.textAlignment = .right
        return label
    }()
    
    private lazy var lowPriceLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.lowPrice
        label.font = Fonts.lowTextFont
        label.textColor = Colors.textColor
        return label
    }()
    
    private lazy var lowPrice: UILabel = {
        let label = UILabel()
        label.font = Fonts.lowTextFont
        label.textColor = Colors.textColor
        label.textAlignment = .right
        return label
    }()
    
    private lazy var lowMarketLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.soLowTextFont
        label.textColor = Colors.textColor
        label.textAlignment = .right
        return label
    }()
    
    private lazy var avaliableAmountLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.avaliable
        label.font = Fonts.textFont
        label.textColor = Colors.textColor
        return label
    }()
    
    private lazy var avaliableAmount: UILabel = {
        let label = UILabel()
        label.font = Fonts.textFont
        label.textColor = Colors.textColor
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var changePercentLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.changePercent
        label.font = Fonts.lowTextFont
        label.textColor = Colors.textColor
        return label
    }()
    
    private lazy var changePercent: UILabel = {
        let label = UILabel()
        label.font = Fonts.lowTextFont
        label.textColor = Colors.textColor
        label.textAlignment = .right
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView()
        imageView.image = image
        return imageView
    }()
    
    private lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = Colors.mainColor
        line.contentMode = .scaleToFill
        return line
    }()
    private lazy var lineView2: UIView = {
        let line = UIView()
        line.backgroundColor = Colors.mainColor
        line.contentMode = .scaleToFill
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: Private extension
private extension DetailView {
    
    func addView() {
        self.addSubview(avaregePriceLabel)
        self.addSubview(avaregePrice)
        
        self.addSubview(highPriceLabel)
        self.addSubview(highPrice)
        self.addSubview(highMarketLabel)
        self.addSubview(lowPriceLabel)
        self.addSubview(lowPrice)
        self.addSubview(lowMarketLabel)
        
        self.addSubview(avaliableAmountLabel)
        self.addSubview(avaliableAmount)
        self.addSubview(changePercentLabel)
        self.addSubview(changePercent)
        self.addSubview(arrowImage)
        
        self.addSubview(lineView)
        self.addSubview(lineView2)
    }
    func setConstraint() {
        self.makeAvaregePriceConstraints()
        self.makeAvaregePriceLabelConstraints()
        
        self.makeHighPriceConstraints()
        self.makehighPriceLabelConstraints()
        self.makehighMarketLabelConstraints()
        
        self.makeLowPriceConstraints()
        self.makelowPriceLabelConstraints()
        self.makelowMarketLabelConstraints()
        
        self.makeavaliableAmountConstraints()
        self.makeavaliableAmountLabelConstraints()
        
        self.makearrowImageConstraints()
        self.makechangePercentConstraints()
        self.makechangePercentLabelConstraints()
        
        self.makeLineViewConstraints()
        self.makeLineView2Constraints()
    }
    
    func makeAvaregePriceConstraints() {
        self.avaregePrice.translatesAutoresizingMaskIntoConstraints = false
        self.avaregePrice.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.normalTopSpacing).isActive = true
        self.avaregePrice.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.avaregePrice.widthAnchor.constraint(equalToConstant: Metrics.maxWidth).isActive = true
        
    }
    
    func makeAvaregePriceLabelConstraints() {
        self.avaregePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.avaregePriceLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.normalTopSpacing).isActive = true
        self.avaregePriceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.avaregePriceLabel.trailingAnchor.constraint(equalTo: self.avaregePrice.leadingAnchor, constant: -Metrics.minimalSpacing).isActive = true
    }
    
    func makearrowImageConstraints() {
        self.arrowImage.translatesAutoresizingMaskIntoConstraints = false
        self.arrowImage.topAnchor.constraint(equalTo: self.avaregePriceLabel.bottomAnchor, constant: Metrics.minimumTopSpacing).isActive = true
        self.arrowImage.heightAnchor.constraint(equalToConstant: Metrics.standartSpacing).isActive = true
        self.arrowImage.widthAnchor.constraint(equalToConstant: Metrics.standartSpacing).isActive = true
        self.arrowImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
    }
    
    func makechangePercentConstraints() {
        self.changePercent.translatesAutoresizingMaskIntoConstraints = false
        self.changePercent.topAnchor.constraint(equalTo: self.avaregePriceLabel.bottomAnchor, constant: Metrics.minimumTopSpacing).isActive = true
        self.changePercent.trailingAnchor.constraint(equalTo: self.arrowImage.leadingAnchor, constant: -Metrics.minimalSpacing).isActive = true
        self.changePercent.widthAnchor.constraint(equalToConstant: Metrics.minWidth).isActive = true
    }
    
    func makechangePercentLabelConstraints() {
        self.changePercentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.changePercentLabel.topAnchor.constraint(equalTo: self.avaregePriceLabel.bottomAnchor, constant: Metrics.minimumTopSpacing).isActive = true
        self.changePercentLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.changePercentLabel.trailingAnchor.constraint(equalTo: self.changePercent.leadingAnchor, constant: -Metrics.minimalSpacing).isActive = true
    }
    
    func makeLineView2Constraints() {
        self.lineView2.translatesAutoresizingMaskIntoConstraints = false
        self.lineView2.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.lineView2.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.lineView2.topAnchor.constraint(equalTo: self.changePercentLabel.bottomAnchor, constant: Metrics.normalTopSpacing).isActive = true
        self.lineView2.heightAnchor.constraint(equalToConstant: Metrics.lineHeight).isActive = true
    }
    
    func makeHighPriceConstraints() {
        self.highPrice.translatesAutoresizingMaskIntoConstraints = false
        self.highPrice.topAnchor.constraint(equalTo: self.lineView2.bottomAnchor, constant: Metrics.standartSpacing).isActive = true
        self.highPrice.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.highPrice.widthAnchor.constraint(equalToConstant: Metrics.maxWidth).isActive = true
    }
    
    
    func makehighPriceLabelConstraints() {
        self.highPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.highPriceLabel.topAnchor.constraint(equalTo: self.lineView2.bottomAnchor, constant: Metrics.standartSpacing).isActive = true
        self.highPriceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.highPriceLabel.trailingAnchor.constraint(equalTo: self.highPrice.leadingAnchor, constant: -Metrics.minimalSpacing).isActive = true
    }
        
    func makehighMarketLabelConstraints() {
        self.highMarketLabel.translatesAutoresizingMaskIntoConstraints = false
        self.highMarketLabel.topAnchor.constraint(equalTo: self.highPriceLabel.bottomAnchor, constant: Metrics.minimalSpacing).isActive = true
        self.highMarketLabel.widthAnchor.constraint(equalToConstant: Metrics.minWidth).isActive = true
        self.highMarketLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
    }
    
    func makeLowPriceConstraints() {
        self.lowPrice.translatesAutoresizingMaskIntoConstraints = false
        self.lowPrice.topAnchor.constraint(equalTo: self.highMarketLabel.bottomAnchor, constant: Metrics.standartSpacing).isActive = true
        self.lowPrice.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.lowPrice.widthAnchor.constraint(equalToConstant: Metrics.maxWidth).isActive = true
    }
    
    func makelowPriceLabelConstraints() {
        self.lowPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.lowPriceLabel.topAnchor.constraint(equalTo: self.highMarketLabel.bottomAnchor, constant: Metrics.standartSpacing).isActive = true
        self.lowPriceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.lowPriceLabel.trailingAnchor.constraint(equalTo: self.lowPrice.leadingAnchor, constant: -Metrics.minimalSpacing).isActive = true
    }
    
    func makelowMarketLabelConstraints() {
        self.lowMarketLabel.translatesAutoresizingMaskIntoConstraints = false
        self.lowMarketLabel.topAnchor.constraint(equalTo: self.lowPriceLabel.bottomAnchor, constant: Metrics.minimalSpacing).isActive = true
        self.lowMarketLabel.widthAnchor.constraint(equalToConstant: Metrics.minWidth).isActive = true
        self.lowMarketLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
    }
    
    func makeLineViewConstraints() {
        self.lineView.translatesAutoresizingMaskIntoConstraints = false
        self.lineView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.lineView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.lineView.topAnchor.constraint(equalTo: self.lowMarketLabel.bottomAnchor, constant: Metrics.standartSpacing).isActive = true
        self.lineView.heightAnchor.constraint(equalToConstant: Metrics.lineHeight).isActive = true
    }
    
    func makeavaliableAmountConstraints() {
        self.avaliableAmount.translatesAutoresizingMaskIntoConstraints = false
        self.avaliableAmount.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: Metrics.normalTopSpacing).isActive = true
        self.avaliableAmount.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.avaliableAmount.widthAnchor.constraint(equalToConstant: Metrics.avaliableAmountWidth).isActive = true
    }
    
    func makeavaliableAmountLabelConstraints() {
        self.avaliableAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.avaliableAmountLabel.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: Metrics.normalTopSpacing).isActive = true
        self.avaliableAmountLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.avaliableAmountLabel.trailingAnchor.constraint(equalTo: self.avaliableAmount.leadingAnchor, constant: -Metrics.minimalSpacing).isActive = true
    }
}

//MARK: IDetailView
extension DetailView: IDetailView {
    func setAllView(averagePrice: String, highPrice: Double,
                    highMarket: String, lowPrice: Double,
                    lowMarket: String, avaliableAmount: String,
                    changePercent: Double) {
        
        guard let doubleAvPrice = Double(averagePrice) else { return }
        let doublePriceText = String(format:"%.3f", doubleAvPrice)
        self.avaregePrice.text = "\(doublePriceText) $"
        
        let highPriceText = String(format:"%.3f", highPrice)
        self.highPrice.text = "\(highPriceText) $"
        
        self.highMarketLabel.text = highMarket
        
        let lowPriceText = String(format:"%.3f", lowPrice)
        self.lowPrice.text = "\(lowPriceText) $"
        
        self.lowMarketLabel.text = lowMarket
        
        guard let intAvAmount = Double(avaliableAmount) else { return }
        let intAvAmountText = String(format:"%.0f", intAvAmount)
        self.avaliableAmount.text = "\(intAvAmountText) pcs"
        
        let changePercentText = String(format: "%.2f", changePercent)
        self.changePercent.text = "\(changePercentText) %"
        
        if changePercent > 0 {
            self.arrowImage.image = UIImage(systemName: Literal.upArrow)
            self.arrowImage.tintColor = Colors.mainColor
        } else {
            self.arrowImage.image = UIImage(systemName: Literal.downArrow)
            self.arrowImage.tintColor = Colors.redColor
        }
    }
}

