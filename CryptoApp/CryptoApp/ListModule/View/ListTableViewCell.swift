//
//  ListTableViewCell.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import UIKit

protocol IListTableViewCell {
    var setPriceHandler: (() -> String)? { get set }
    var setPercentHandler: (() -> String)? { get set }
}


final class ListTableViewCell: UITableViewCell {
    
    private enum Literal {
        static let cellId = "cell"
    }
    
    private enum Fonts {
        static let textFont = UIFont(name: "HiraginoSans-W3", size: 14)
    }
    
    private enum Colors {
        static let textColor: UIColor = .white
        static let riseColor = UIColor(red: 103/255, green: 222/255, blue: 165/255, alpha: 1)
        static let declineColor: UIColor = .systemRed
        static let backgroundColor: UIColor = .black
    }
    
    private enum Metrics {
        static let zeroSpacing = CGFloat(0)
        static let percentLabelWidth = CGFloat(100)
        static let standartHeight = CGFloat(50)
        static let priceLabelWidth = CGFloat(150)
        static let priceLabelLeading = CGFloat(10)
    }
    
    var setPriceHandler: (() -> String)?
    var setPercentHandler: (() -> String)?
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.textFont
        label.textColor = Colors.textColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.textFont
        label.textColor = Colors.riseColor
        label.textAlignment = .right
        return label
    }()
    
    static let reuseIdentifier = Literal.cellId
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.addSubview(priceLabel)
        super.addSubview(percentLabel)
        self.makeLabelsConstraints()
        self.backgroundColor = Colors.backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func makeLabelsConstraints(){
        self.percentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.percentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.percentLabel.widthAnchor.constraint(equalToConstant: Metrics.percentLabelWidth).isActive = true
        self.percentLabel.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
        self.percentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.zeroSpacing).isActive = true
        
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceLabel.trailingAnchor.constraint(equalTo: self.percentLabel.leadingAnchor, constant: Metrics.priceLabelLeading).isActive = true
        self.priceLabel.widthAnchor.constraint(equalToConstant: Metrics.priceLabelWidth).isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant: Metrics.standartHeight).isActive = true
        self.priceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.zeroSpacing).isActive = true
    }
}

extension ListTableViewCell: IListTableViewCell {
    func setLabelsText(price: String, percent: String) {
        
        guard let doublePrice = Double(price) else { return }
        
        let doublePriceText = String(format:"%.3f", doublePrice)
        self.priceLabel.text = "\(doublePriceText) USD"
        
        
        guard let doublePercent = Double(percent) else { return }
        
        let doublePercentText = String(format: "%.2f", doublePercent)
        self.percentLabel.text = "\(doublePercentText) %"
        
        if doublePercent > 0 {
            self.percentLabel.textColor = Colors.riseColor
        } else {
            self.percentLabel.textColor = Colors.declineColor
        }
    }
}

