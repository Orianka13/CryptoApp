//
//  ListView.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import UIKit

protocol IListView {
    func getTableView() -> ListTableView
    var onTouchedHandler: ((String) -> Void)? { get set }
    var searchBarHandler: ((String) -> Void)? { get set }
}

final class ListView: UIView {
    
    private enum Metrics {
        static let standartSpacing = CGFloat(20)
        static let tableViewHeight = CGFloat(1.3)
        static let zeroSpacing = CGFloat(0)
        static let buttonSpacing = CGFloat(30)
        static let buttonCornerRadius = CGFloat(10)
        static let buttonAlpha = CGFloat(0.3)
        static let selectedButtonAlpha = CGFloat(1)
        static let hightSV = CGFloat(20)
        static let spacingSV = CGFloat(5)
        
    }
    
    private enum Fonts {
        static let textFont = UIFont(name: "HiraginoSans-W3", size: 15)
    }
    
    private enum Colors {
        static let textColor: UIColor = .white
        static let buttonColor: UIColor = .darkGray
    }
    
    private enum Literal {
        static let starImage = "star.fill"
        static let sortImage = "arrow.up.arrow.down"
        static let allButtonName = "All"
        static let convertButtonName = "Convert"
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .black
        searchBar.searchTextField.textColor = Colors.textColor
        searchBar.searchTextField.font = Fonts.textFont
        return searchBar
    }()
    
    private lazy var allButton: UIButton = {
        let button = UIButton()
        button.setTitle(Literal.allButtonName, for: .normal)
        button.tintColor = Colors.textColor
        button.backgroundColor = Colors.buttonColor
        button.layer.cornerRadius = Metrics.buttonCornerRadius
        button.alpha = Metrics.buttonAlpha
        button.isSelected = true
        if button.isSelected {
            button.alpha = Metrics.selectedButtonAlpha
        }
        return button
    }()
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Literal.starImage), for: .normal)
        button.tintColor = Colors.textColor
        button.backgroundColor = Colors.buttonColor
        button.layer.cornerRadius = Metrics.buttonCornerRadius
        button.alpha = Metrics.buttonAlpha
        return button
    }()
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Literal.sortImage), for: .normal)
        button.tintColor = Colors.textColor
        button.backgroundColor = Colors.buttonColor
        button.layer.cornerRadius = Metrics.buttonCornerRadius
        button.alpha = Metrics.buttonAlpha
        return button
    }()
    private lazy var convertButton: UIButton = {
        let button = UIButton()
        button.setTitle(Literal.convertButtonName, for: .normal)
        button.tintColor = Colors.textColor
        button.backgroundColor = Colors.buttonColor
        button.layer.cornerRadius = Metrics.buttonCornerRadius
        button.alpha = Metrics.buttonAlpha
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = Metrics.spacingSV
        
        stackView.addArrangedSubview(allButton)
        stackView.addArrangedSubview(favoriteButton)
        stackView.addArrangedSubview(convertButton)
        stackView.addArrangedSubview(sortButton)
        
        return stackView
    }()
    
    private var tableView = ListTableView()
    
    var onTouchedHandler: ((String) -> Void)?
    var searchBarHandler: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setConstraint()
        self.searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: Private extension
private extension ListView {
    
    func addView() {
        self.addSubview(tableView)
        self.addSubview(searchBar)
        
        self.addSubview(stackView)
    }
    func setConstraint() {
        self.makeTableViewConstraints()
        self.makeSearchBarConstraints()
        
        self.makeStackViewConstraits()
    }
    
    func makeTableViewConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: Metrics.spacingSV).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.buttonSpacing).isActive = true
        self.tableView.heightAnchor.constraint(equalToConstant: self.frame.size.height / Metrics.tableViewHeight).isActive = true
    }
    
    func makeSearchBarConstraints() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
    }
    
    func makeStackViewConstraits() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.widthAnchor.constraint(equalToConstant: 50).isActive = false
        self.stackView.heightAnchor.constraint(equalToConstant: Metrics.hightSV).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: Metrics.spacingSV).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.buttonSpacing).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.buttonSpacing).isActive = true
    }
}

//MARK: IListView
extension ListView: IListView {
    
    func getTableView() -> ListTableView {
        return self.tableView
    }
}

//MARK: UISearchBarDelegate
extension ListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBarHandler?(searchText)
    }
}
