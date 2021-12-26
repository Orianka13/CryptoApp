//
//  ConvertViewController.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 26.12.2021.
//

import UIKit

protocol IConvertViewController {
 
}

final class ConvertViewController: UIViewController {
    
    private enum Colors {
        static let mainBackgroundColor: UIColor = .black
    }

    
    private let convertView: ConvertView
    private let presenter: IConvertPresenter?
    
    struct Dependencies {
        let presenter: IConvertPresenter
    }
    
    init(dependencies: Dependencies) {
        self.convertView = ConvertView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(controller: self, view: self.convertView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(convertView)
        
        self.view.backgroundColor = Colors.mainBackgroundColor
    }
}

//MARK: Private extension
private extension ConvertViewController {
    

}

extension ConvertViewController: IConvertViewController {
   
}


