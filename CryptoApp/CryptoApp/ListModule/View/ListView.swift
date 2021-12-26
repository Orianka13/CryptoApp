//
//  ListView.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import UIKit

protocol IListView {
    func getTableView() -> ListTableView
    var allHandler: (() -> Void)? { get set }
    var searchBarHandler: ((String) -> Void)? { get set }
    var favoriteOnHandler: (() -> Void)? { get set }
    var convertHandler: (() -> Void)? { get set }
    var sortHandler: (() -> Void)? { get set }
}

final class ListView: UIView {
    
    private enum Metrics {
        static let standartSpacing = CGFloat(20)
        static let tableViewHeight = CGFloat(1.3)
        static let zeroSpacing = CGFloat(0)
        static let buttonSpacing = CGFloat(30)
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
    
    private lazy var segmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl(items: [Literal.allButtonName,
                                                         UIImage(systemName: Literal.starImage) as Any,
                                                         Literal.convertButtonName,
                                                         UIImage(systemName: Literal.sortImage) as Any])
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        return segmentedControl
        
    }()
    
    private var tableView = ListTableView()
    
    var allHandler: (() -> Void)?
    var searchBarHandler: ((String) -> Void)?
    var favoriteOnHandler: (() -> Void)?
    var convertHandler: (() -> Void)?
    var sortHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setConstraint()
        self.searchBar.delegate = self
        self.segmentedControl.selectedSegmentIndex = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: Private extension
private extension ListView {
    
    @objc func indexChanged() {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            self.allHandler?()
        case 1:
            self.favoriteOnHandler?()
        case 2:
            self.convertHandler?()
        case 3:
            self.sortHandler?()
        default:
            self.allHandler?()
        }
    }
    
    func addView() {
        self.addSubview(tableView)
        self.addSubview(searchBar)

        self.addSubview(segmentedControl)
    }
    func setConstraint() {
        self.makeTableViewConstraints()
        self.makeSearchBarConstraints()
        self.makeSegmentedControlConstraints()
    }
    
    func makeTableViewConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: Metrics.spacingSV).isActive = true
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
    
    func makeSegmentedControlConstraints() {
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.segmentedControl.heightAnchor.constraint(equalToConstant: Metrics.hightSV).isActive = true
        self.segmentedControl.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: Metrics.spacingSV).isActive = true
        self.segmentedControl.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.buttonSpacing).isActive = true
        self.segmentedControl.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.buttonSpacing).isActive = true
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
