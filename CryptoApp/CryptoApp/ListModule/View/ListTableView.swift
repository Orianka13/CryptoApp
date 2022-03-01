//
//  ListTableView.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation
import UIKit

protocol IListTableView {
    var didSelectRowAtHandler: ((IndexPath) -> Void)? { get set }
    var numberOfRowsInSectionHandler: (() -> Int)? { get set }
    var cellForRowAtHandler: ((ListTableViewCell, IndexPath) -> String)? { get set }
    func reloadTableView()
    func getTableView() -> UITableView
    var refreshControlHandler: (() -> Void)? { get set }
    func getRefreshControl() -> UIRefreshControl
}

final class ListTableView: UIView {
    
    private enum Metrics {
        static let zeroSpacing = CGFloat(0)
    }
    
    private enum Colors {
        static let backgroundColor: UIColor = .black
        static let textColor: UIColor = .white
        static let mainColor = UIColor(red: 103/255, green: 222/255, blue: 165/255, alpha: 1)
    }
    
    private enum Fonts {
        static let textFont = UIFont(name: "HiraginoSans-W3", size: 18)
    }
    
    private var tableView: UITableView = UITableView()
    private var refreshControl = UIRefreshControl()
    
    var didSelectRowAtHandler: ((IndexPath) -> Void)?
    var numberOfRowsInSectionHandler: (() -> Int)?
    var cellForRowAtHandler: ((ListTableViewCell, IndexPath) -> String)?
    var refreshControlHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = Colors.backgroundColor
        self.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        let attributedString = NSMutableAttributedString(string:"Pull to update")
        let range : NSRange = ("Pull to update" as NSString).range(of: "Pull to update")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.mainColor, range: range)
        self.refreshControl.attributedTitle = attributedString
        self.refreshControl.tintColor = Colors.mainColor
        
        self.refreshControl.addTarget(self, action: #selector(refreshTableView),for: UIControl.Event.valueChanged)
        
        self.tableView.addSubview(refreshControl)
        
        self.addView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func refreshTableView() {
        self.refreshControlHandler?()
    }
}

//MARK: Private extension
private extension ListTableView {
    
    func addView() {
        self.addSubview(tableView)
    }
    
    func setConstraint() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
    }
}

//MARK: UITableViewDataSource
extension ListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = numberOfRowsInSectionHandler?()
        return count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as! ListTableViewCell
        let name = self.cellForRowAtHandler?(cell, indexPath)
        cell.textLabel?.text = name
        cell.textLabel?.textColor = Colors.textColor
        cell.textLabel?.font = Fonts.textFont
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectRowAtHandler?(indexPath)
    }
}


//MARK: IListTableView
extension ListTableView: IListTableView {
    func getRefreshControl() -> UIRefreshControl {
        return self.refreshControl
    }
    
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getTableView() -> UITableView {
        return self.tableView
    }
}
