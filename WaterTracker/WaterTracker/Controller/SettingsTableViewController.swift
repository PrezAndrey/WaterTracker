//
//  SettingsTableViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.05.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let healthKit = HealthKitAdapter()
    
    @IBOutlet weak var currentPeriod: UILabel!
    @IBOutlet weak var currentAim: UILabel!
    @IBOutlet weak var notficationSwitch: UISwitch!
    
    private let notifications = Notifications()
    private let waterModel = WaterModel()
    private let dateService = DateService()
    
    @IBAction func didUploadDataToHK(_ sender: Any) {
        print("Uploading data to HealthKit...")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    @IBAction func didResetSettings(_ sender: Any) {
        resetAlert()
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
  
    @objc func switchNotification() {
        guard let newSettings = waterModel.getUserSettings() else { return }
        waterModel.saveUserSettings(settings: newSettings)
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
    
