//
//  SettingsTableViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.05.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let healthKit = HealthKitAdapter()
    
    @IBOutlet weak var targetCellView: UIView!
    @IBOutlet weak var periodCellView: UIView!
    @IBOutlet weak var notificationCellView: UIView!
    @IBOutlet weak var resetCellView: UIView!
    @IBOutlet weak var hkCellView: UIView!
    
    @IBOutlet weak var currentPeriod: UILabel!
    @IBOutlet weak var currentAim: UILabel!
    @IBOutlet weak var notficationSwitch: UISwitch!
    
    private let notifications = Notifications()
    private let waterModel = WaterModel()
    private let dateService = DateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    private func configureUI() {
        var settings = UserSettings(dayTarget: 0, startDayInterval: 21599, weight: 0, notificationState: false)
        if let existingSettings = waterModel.getUserSettings() {
            settings = existingSettings
        } else {
            waterModel.saveUserSettings(settings: settings)
        }
        currentAim.text = "\(settings.dayTarget ?? 0) ml"
        let newTime = dateService.intervalToDateStr(interval: settings.startDayInterval ?? 21599)
        currentPeriod.text = "\(newTime)"
        
        tableView.reloadData()
    }
    
    private func configureViewCells() {
        let viewList = [targetCellView, periodCellView, notificationCellView, resetCellView, hkCellView]
        let labelList = [currentAim, currentPeriod]
        
        
        for view in viewList {
            guard let cellView = view else { return }
            cellView.layer.cornerRadius = 10
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
    
//    func shake() {
//        let shake = CABasicAnimation (keyPath: "position")
//        shake.duration = 0.1
//        shake.repeatCount = 2
//        shake.autoreverses = true
//        let fromPoint = CGPoint(x:  - 8, y: center.y)
//        let fromValue = NSValue (cgPoint: fromPoint)
//        let toPoint = CGPoint (x: center.× + 8, y: center.y)
//        let toValue = NSValue (cgPoint: toPoint)
//        shake.fromValue = fromValue
//        shake.toValue = toValue
//        layer.add(shake, forkey: "position")
//    }
  
    @objc func switchNotification() {
        guard let newSettings = waterModel.getUserSettings() else { return }
        waterModel.saveUserSettings(settings: newSettings)
        print("Switch is working .....")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: StartingTimeViewController.self) {
            if let timeVC = segue.destination as? StartingTimeViewController {
                timeVC.completion = {[weak self] newAmount in
                    guard let self = self else { return }
                    self.currentPeriod.text = newAmount
                    self.tableView.reloadData()
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            targetCellView.isOpaque = false
        case (1, 0):
            print()
        case (2, 0):
            print()
        case (3, 0):
            print()
        case (4, 0):
            print()
        default:
            print("MainSettings Cell Error")
        }
        return indexPath
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            performSegue(withIdentifier: String(describing: AutoAimViewController.self), sender: self)
           
        case (1, 0):
            performSegue(withIdentifier: String(describing: StartingTimeViewController.self), sender: self)
        case (2, 0):
            switchNotification()
        case (3, 0):
            print("Uploading data to HealthKit...")
        case (4, 0):
            resetAlert()
        default:
            print("MainSettings Cell Error")
        }
    }
}


extension SettingsTableViewController {
    
    private func resetAlert() {
        let alertController = UIAlertController(title: "Reset",
                                                message: "Do you want to reset settings",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "Reset", style: .default) { (_) in
            self.resetSettings()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func resetSettings() {
        let newSettings = UserSettings(dayTarget: 0, startDayInterval: 21599, weight: 0)
        waterModel.editSettings(newSettings: newSettings)
        configureUI()
    }
}
