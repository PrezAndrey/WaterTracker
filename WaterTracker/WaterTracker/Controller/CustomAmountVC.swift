//
//  CustomAmountVC.swift
//  WaterTracker
//
//  Created by Андрей  on 14.04.2022.
//

import Foundation
import UIKit

class CustomAmountVC: UIViewController {
    
    private var waterStore = WaterStore()
    
    var completion: ((Double) -> Void)?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func valueDidSet(_ sender: Any) {
        if let newAmount = Double(textField.text!) {
            completion?(newAmount)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
