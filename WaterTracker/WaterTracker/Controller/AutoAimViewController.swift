//
//  AutoAimViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.04.2022.
//

import Foundation
import UIKit
import HealthKit

protocol AutoAimDelegate {
    func updateAim(newAim: Int)
}

class AutoAimViewController: UITableViewController {
    
    
    var userSettings = UserSettings()
    var waterModel = WaterModel()
    let waterCalculator = WaterCalculator()
    

    var settings = UserSettings(dayTarget: 0, startDayInterval: 21599, height: 0, weight: 0)
    
    
    
    
    @IBOutlet weak var startingPeriod: UILabel!
    @IBOutlet weak var aimLable: UILabel!
    @IBOutlet weak var heightLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    
    
    @IBOutlet weak var dateOfBirthLable: UILabel!
    @IBOutlet weak var sexLable: UILabel!
    @IBOutlet weak var bloodTypeLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("current sttings before: \(settings)")
        updateSettings()
        weightLable.text = "\(settings.weight!)кг"
        heightLable.text = "\(settings.height!)см"
        aimLable.text = "\(settings.dayTarget!)мл"
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        waterModel.editSettings(newSettings: settings)
        print("current sttings after: \(settings)")
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
    
    
    
    @IBAction func didFetchDataFromHK(_ sender: Any) {
        let datafromHK = try? waterModel.fetchDataFromHealthKit()
        guard let age = datafromHK?.age,
              let blood = datafromHK?.bloodType,
              let sex = datafromHK?.biologicalSex
        else { return }
        dateOfBirthLable.text = "\(age)"
        bloodTypeLable.text = "\(blood.rawValue)"
        
        switch sex.rawValue {
        case 0:
            sexLable.text = "notSet"
        case 1:
            sexLable.text = "female"
        case 2:
            sexLable.text = "male"
        case 3:
            sexLable.text = "other"
        default:
            return
        }
        
       
        
    }
    
    
    
    @IBAction func didGenerateAim(_ sender: Any) {
        if let currentWeight = settings.weight {
            let newAim = waterCalculator.waterAimGenerator(weight: currentWeight)
            settings.dayTarget = Int(newAim)
            aimLable.text = "\(newAim)мл"
            
            
            
        }
        
    }
    
    
    private func updateSettings() {
        if let newSettings = waterModel.getUserSettings() {
            settings = newSettings
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "openPicker" {
            if let startingTimeVC = segue.destination as? StartingTimeViewController {
                startingTimeVC.completion = {[weak self] startingTime in
                    guard let self = self else { return }
                    print("previous interval: \(self.userSettings.startDayInterval)")
                    let newInterval = self.userSettings.calculateStartDayInterval(setDate: startingTime)
                    self.settings.startDayInterval = newInterval
                    
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
                self.settings.weight = Int(bodyMass) ?? 0
                
                self.weightLable.text = "\(self.settings.weight ?? 0)кг"
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
                self.settings.height = Int(height) ?? 0
                self.heightLable.text = "\(self.settings.height)см"
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
                self.settings.dayTarget = Int(aim) ?? 0
                self.aimLable.text = "\(self.settings.dayTarget)мл"
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

extension AutoAimViewController: AutoAimDelegate {
    func updateAim(newAim: Int) {
        settings.dayTarget = newAim
        
    }
}
