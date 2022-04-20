//
//  AutoAimViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.04.2022.
//

import Foundation
import UIKit


class AutoAimViewController: UITableViewController {
    
    
    var userSettings = UserSettings()
    
    
    
    @IBOutlet weak var startingPeriod: UILabel!
    @IBOutlet weak var aimLable: UILabel!
    @IBOutlet weak var heightLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightLable.text = "\(userSettings.weight)кг"
        heightLable.text = "\(userSettings.height)см"
        aimLable.text = "\(userSettings.dayTarget)мл"
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row is: \(indexPath.row)")
        
        guard indexPath.section == 0 else { return }
        switch indexPath.row {
        case 0:
            weightSetAlert()
        case 1:
            heightSetAlert()
        case 2:
            aimSetAlert()
        case 3:
            return
        default:
            return
        }
        
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "openPicker" {
            if let startingTimeVC = segue.destination as? StartingTimeViewController {
                startingTimeVC.completion = {[weak self] startingTime in
                    guard let self = self else { return }
                    print("previous interval: \(self.userSettings.startDayInterval)")
                    let newInterval = self.userSettings.calculateStartDayInterval(setDate: startingTime)
                    self.userSettings.startDayInterval = newInterval
                    
                    print("new interval is: \(newInterval)")
                    self.startingPeriod.text = "\(startingTime)"
                }
            }
        }
    }
    
    
    
}
// MARK: Alert functions for Weight, Height and Aim

extension AutoAimViewController {
    
    private func weightSetAlert() {
        
        let alertController = UIAlertController(title: "Weight", message: "You can correct a body mass", preferredStyle: .alert)
        let action = UIAlertAction(title: "Set", style: .default) { (action) in
            if let bodyMass = alertController.textFields?.first?.text {
                self.userSettings.weight = Int(bodyMass) ?? 0
                self.weightLable.text = "\(self.userSettings.weight)кг"
            }
            else {
                print("Error")
            }
        }
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    private func heightSetAlert() {
        
        let alertController = UIAlertController(title: "Height", message: "You can correct a height", preferredStyle: .alert)
        let action = UIAlertAction(title: "Set", style: .default) { (action) in
            if let height = alertController.textFields?.first?.text {
                self.userSettings.height = Int(height) ?? 0
                self.heightLable.text = "\(self.userSettings.height)см"
            }
            else {
                print("Error")
            }
        }
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    private func aimSetAlert() {
        
        let alertController = UIAlertController(title: "Aim", message: "You can correct a day aim", preferredStyle: .alert)
        let action = UIAlertAction(title: "Set", style: .default) { (action) in
            if let aim = alertController.textFields?.first?.text {
                self.userSettings.dayTarget = Int(aim) ?? 0
                self.aimLable.text = "\(self.userSettings.dayTarget)мл"
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
