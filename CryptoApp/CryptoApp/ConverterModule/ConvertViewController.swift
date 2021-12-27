//
//  ConvertViewController.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 26.12.2021.
//

import UIKit

protocol IConvertViewController {
    func showAlert(message: String)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

//MARK: IConvertViewController

extension ConvertViewController: IConvertViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Обновите страницу", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


