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
    }
    
    private enum Fonts {
        static let textFont = UIFont(name: "HiraginoSans-W3", size: 15)
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .black
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.font = Fonts.textFont
        return searchBar
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
    }
    func setConstraint() {
        self.makeTableViewConstraints()
        self.makeSearchBarConstraints()
    }
    
    func makeTableViewConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.tableView.heightAnchor.constraint(equalToConstant: self.frame.size.height / Metrics.tableViewHeight).isActive = true
    }
    
    func makeSearchBarConstraints() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
    }
}

//MARK: IListView
extension ListView: IListView {
    
    func getTableView() -> ListTableView {
        return self.tableView
    }
}

extension ListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBarHandler?(searchText)
    }
}
