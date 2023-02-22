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
    
    @IBOutlet weak var weightCellView: UIView!
    @IBOutlet weak var targetCellView: UIView!
    @IBOutlet weak var hkCellView: UIView!
    @IBOutlet weak var getHKDCellView: UIView!
    @IBOutlet weak var aimGenerationCellView: UIView!
    
    @IBOutlet weak var aimLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    @IBOutlet weak var dateOfBirthLable: UILabel!
    @IBOutlet weak var sexLable: UILabel!
    @IBOutlet weak var bloodTypeLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateSettings()
        configureWithSettings()
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        waterModel.editSettings(newSettings: settings)
    }
    
    func generateAim() {
        if let currentWeight = settings.weight {
            let newAim = waterCalculator.waterAimGenerator(weight: currentWeight)
            settings.dayTarget = Int(newAim)
            aimLable.text = "\(newAim) мл"
        }
    }
    
    func configureUI() {
        let viewList = [weightCellView, targetCellView, hkCellView, getHKDCellView, aimGenerationCellView]
        let labelList = [aimLable, weightLable, dateOfBirthLable, sexLable, bloodTypeLable]
        
        for view in viewList {
            guard let cellView = view else { return }
            cellView.layer.cornerRadius = 15
            cellView.layer.borderWidth = 2
            cellView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        }
        
        for label in labelList {
            guard let label = label else { return }
            label.layer.cornerRadius = 5
            label.layer.borderWidth = 2
            label.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        }
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
        if let weight = settings.weight {
            weightLable.text = "\(weight) кг"
        } else {
            weightLable.text = "0 кг"
        }
        if let target  = settings.dayTarget {
            aimLable.text = "\(Int(target)) мл"
        } else {
            aimLable.text = "0 мл"
        }
    }
}


// MARK: Alert functions for Weight, Height and Aim
extension AutoAimViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0), (1, 0):
            valueSetAlert(indexPath: indexPath)
        case (2, 0):
            print("HealthKit values")
        case (3, 0):
            generateAim()
        case (4, 0):
            HKDataFetch()
        default:
            print("Error cell")
        }
    }
    
    private func valueSetAlert(indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            showAlert("Weight") { [weak self] setting in
                self?.settings.weight = Int(setting)
                self?.configureWithSettings()
            }
        case (1, 0):
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
