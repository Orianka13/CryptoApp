//
//  PickerView.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 27.12.2021.
//

import Foundation

import UIKit

extension ConvertView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.elementPicker1 {
            let title = self.pickerTitleHandler?(row)
            return title
        } else if pickerView == self.elementPicker2 {
            let title = self.picker2TitleHandler?(row)
            return title
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.elementPicker1 {
            self.pickerDidSelectHandler?(row)
        } else if pickerView == self.elementPicker2 {
            self.picker2DidSelectHandler?(row)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView == self.elementPicker1 {
            let title = self.pickerTitleHandler?(row)
            let attributedString = NSAttributedString(string: title ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            return attributedString
            
        } else if pickerView == self.elementPicker2 {
            let title = self.picker2TitleHandler?(row)
            let attributedString = NSAttributedString(string: title ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            return attributedString
        }
        return NSAttributedString()
    }
}

//MARK: - UIPickerViewDataSource

extension ConvertView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.elementPicker1 {
            let count = self.pickerCountHandler?() ?? 1
            return count
        } else if pickerView == self.elementPicker2 {
            let count = self.picker2CountHandler?() ?? 1
            return count
        }
        return 0
    }
}
