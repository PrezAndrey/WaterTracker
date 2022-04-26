//
//  SettingsViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 21.04.2022.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    
    private var waterModel = WaterModel()
    
    
    
    @IBAction func didSetDayAim(_ sender: Any) {
        aimSetAlert()
    }
    
    
    
    
    @IBAction func didReset(_ sender: Any) {
        resetAlert()
    }
    
    
    
    private func resetAlert() {
        
        let alertController = UIAlertController(title: "Reset", message: "Do you want to reset settings", preferredStyle: .alert)
        let action = UIAlertAction(title: "Reset", style: .default) { (action) in
            self.resetSettings()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
       
        
        alertController.addAction(cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    private func resetSettings() {
        
        let newSettings = UserSettings(dayTarget: 0, startDayInterval: 21599, height: 0, weight: 0)
        waterModel.editSettings(newSettings: newSettings)
        
        
    }
    
    private func setNewAim(target: Int) {
        if let currentSettings = waterModel.getUserSettings() {
            var newSettings = currentSettings
            newSettings.dayTarget = target
            waterModel.editSettings(newSettings: newSettings)
        }
    }
    
    private func aimSetAlert() {

        let alertController = UIAlertController(title: "Aim", message: "You can correct a day aim", preferredStyle: .alert)
        let action = UIAlertAction(title: "Set", style: .default) { (action) in
            if let aim = alertController.textFields?.first?.text {
                self.setNewAim(target: Int(aim) ?? 0)
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
