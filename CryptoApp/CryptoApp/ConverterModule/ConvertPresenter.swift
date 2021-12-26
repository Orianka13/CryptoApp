//
//  ConvertPresenter.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 26.12.2021.
//

import Foundation

protocol IConvertPresenter {
    func loadView(controller: ConvertViewController, view: IConvertView)
}

final class ConvertPresenter {
    
    private weak var controller: ConvertViewController?
    private var view: IConvertView?
    
}

//MARK: Private extension

private extension ConvertPresenter {
    
    func setHandlers() {
        self.view?.goBackHandler = {
            self.controller?.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: IAuthPresenter
extension ConvertPresenter: IConvertPresenter {
    
    func loadView(controller: ConvertViewController, view: IConvertView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
}
