//
//  SettingsViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 21.04.2022.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    var autoAimDelegate: AutoAimDelegate?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.autoAimDelegate = AutoAimViewController()
    }
    
    @IBAction func didSetDayAim(_ sender: Any) {
        aimSetAlert()
    }
    
    
    private func aimSetAlert() {

        let alertController = UIAlertController(title: "Aim", message: "You can correct a day aim", preferredStyle: .alert)
        let action = UIAlertAction(title: "Set", style: .default) { (action) in
            if let aim = alertController.textFields?.first?.text {
                self.autoAimDelegate?.updateAim(newAim: Int(aim) ?? 0)
            }
            else {
                print("Error")
            }
        }

        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)

    }
    
    
}
