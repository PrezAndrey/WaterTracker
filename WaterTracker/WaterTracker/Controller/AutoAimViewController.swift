//
//  AutoAimViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.04.2022.
//

import Foundation
import UIKit
import HealthKit



class AutoAimViewController: UITableViewController {
    
    
    var userSettings = UserSettings()
    var waterModel = WaterModel()
    let waterCalculator = WaterCalculator()
    

    var settings = UserSettings(dayTarget: 0, startDayInterval: 21599, weight: 0)
    
    
    
    
    @IBOutlet weak var startingPeriod: UILabel!
    @IBOutlet weak var aimLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    
    
    @IBOutlet weak var dateOfBirthLable: UILabel!
    @IBOutlet weak var sexLable: UILabel!
    @IBOutlet weak var bloodTypeLable: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("current sttings before: \(settings)")
        updateSettings()
        weightLable.text = "\(settings.weight!)кг"
        aimLable.text = "\(settings.dayTarget!)мл"
        
    }
    
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        waterModel.editSettings(newSettings: settings)
        print("current settings after: \(settings)")
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row is: \(indexPath.row)")
        
        valueSetAlert(indexPath: indexPath)
        
    }
    
    enum HKSex: Int {
        case notSet
        case female
        case male
        case other
        
        var name: String {
            switch self {
            case .notSet: return "Not Set"
            case .female: return "Female"
            case .male: return "Male"
            case .other: return "Other"
            }
        }
    }
    
    
    @IBAction func didFetchDataFromHK(_ sender: Any) {
        let datafromHK = try? waterModel.fetchDataFromHealthKit()
        guard let age = datafromHK?.age,
              let blood = datafromHK?.bloodType,
              let sex = datafromHK?.biologicalSex,
              let hkSex = HKSex(rawValue: sex.rawValue)
        else { return }
        dateOfBirthLable.text = "\(age)"
        bloodTypeLable.text = "\(blood.rawValue)"
        sexLable.text = hkSex.name
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
    
    
    private func valueSetAlert(indexPath: IndexPath) {
        
        var title = "Weight"
        var newLable = self.weightLable
        
        
        guard indexPath.section == 0 else { return }
        switch indexPath.row {
        case 0:
            title = "Weight"
            newLable = self.weightLable
        case 1:
            title = "Aim"
            newLable = self.aimLable
        case 2:
            return
        default:
            return
        }
        
        let alertController = UIAlertController(title: "\(title)", message: "You can correct \(title.lowercased())", preferredStyle: .alert)
        let action = UIAlertAction(title: "Set", style: .default) { (action) in
            if let set = alertController.textFields?.first?.text {
                let setting = Int(set) ?? 0
                if newLable == self.weightLable {
                    self.settings.weight = setting
                    newLable?.text = "\(setting)кг"
                }
                else {
                    self.settings.dayTarget = setting
                    newLable?.text = "\(setting)мл"
                }
                
                
                
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


