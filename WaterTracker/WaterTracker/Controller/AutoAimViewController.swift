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
    
    let waterModel = WaterModel()
    let waterCalculator = WaterCalculator()
    
    var settings = UserSettings(dayTarget: 0, weight: 0)
    
    @IBOutlet weak var aimLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    @IBOutlet weak var dateOfBirthLable: UILabel!
    @IBOutlet weak var sexLable: UILabel!
    @IBOutlet weak var bloodTypeLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSettings()
        configureWithSettings()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        waterModel.editSettings(newSettings: settings)
    }
    

    @IBAction func didFetchDataFromHK(_ sender: Any) {
        
        HKDataFetch()
    }
    
    
    @IBAction func didGenerateAim(_ sender: Any) {
       
        if let currentWeight = settings.weight {
            
            let newAim = waterCalculator.waterAimGenerator(weight: currentWeight)
            settings.dayTarget = Int(newAim)
            aimLable.text = "\(newAim) мл"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        valueSetAlert(indexPath: indexPath)
    }
}



// MARK: Settings configurations

private extension AutoAimViewController {
    
    func updateSettings() {
        if let newSettings = waterModel.getUserSettings() {
            settings = newSettings
        }
    }
    
    func configureWithSettings() {
        
        guard let weight = settings.weight,
              let target = settings.dayTarget,
              let interval = settings.startDayInterval
        else { return }
        
        weightLable.text = "\(weight) кг"
        aimLable.text = "\(target) мл"
    }
    
}



// MARK: Alert functions for Weight, Height and Aim

extension AutoAimViewController {
    
    private func valueSetAlert(indexPath: IndexPath) {
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            showAlert("Weight") { [weak self] setting in
                self?.settings.weight = Int(setting)
                self?.configureWithSettings()
            }
        case (0, 1):
            showAlert("Aim") { [weak self] setting in
                self?.settings.dayTarget = Int(setting)
                self?.configureWithSettings()
            }
        default:
            return
        }
    }
    
    
    private func showAlert(_ title: String, completion: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: "\(title)", message: "You can correct \(title.lowercased())", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Set", style: .default) { (_) in
            
            completion(alertController.textFields?.first?.text ?? "")
        }
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}



// MARK: HealthKit configuration

extension AutoAimViewController {
      
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
    
    
    private func HKDataFetch() {
        
        let datafromHK = try? waterModel.fetchDataFromHealthKit()
        guard let age = datafromHK?.age,
              let blood = datafromHK?.bloodType,
              let sex = datafromHK?.biologicalSex,
              let hkSex = HKSex(rawValue: sex.rawValue),
              let bodyMass = datafromHK?.bodyMass
        else { return }
        
        dateOfBirthLable.text = "\(age)"
        bloodTypeLable.text = "\(blood.rawValue)"
        sexLable.text = hkSex.name
        print("_____________________The body mass is \(bodyMass)______________________")
    }
}
