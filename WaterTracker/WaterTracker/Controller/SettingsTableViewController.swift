//
//  SettingsTableViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.05.2022.
//

import UIKit



class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var currentPeriod: UILabel!
    @IBOutlet weak var currentAim: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    private let notifications = Notifications()
    private let waterModel = WaterModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationSwitch.addTarget(self, action: #selector(switchNotification), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    
    @IBAction func didResetSettings(_ sender: Any) {
        resetAlert()
    }
    

    private func configureUI() {
        let settings = waterModel.getUserSettings()
        
        setSwitchStatus()
        
        if let aim = settings?.dayTarget {
            currentAim.text = "\(aim) ml"
        }
        
        if let interval = settings?.startDayInterval {
            
            let newTime = UserSettings.convertInterval(interval: interval)
            currentPeriod.text = "\(newTime)"
        }
        
        tableView.reloadData()
    }
  
    
    @objc func switchNotification() {
        
        if notificationSwitch.isOn == false {
            notifications.notificationCenter.removeDeliveredNotifications(withIdentifiers: ["Local Notification"])
    
        }
    }
    
    
    func setSwitchStatus() {
        
        notifications.notificationCenter.getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .notDetermined {
                    self.notificationSwitch.isOn = false
                } else {
                    self.notificationSwitch.isOn = true
                }
            }
        }
    }
    
}



// MARK: - Table view data source

extension SettingsTableViewController {
    
    
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as? SettingCell
//        
//        switch indexPath.row {
//        case 0:
//            guard let aim = waterModel.getUserSettings()?.dayTarget else { return UITableViewCell() }
//            cell?.lable.text = settingButtons[indexPath.row]
//            cell?.valueLable.isHidden = false
//            cell?.valueLable.text = String(aim)
//        case 1:
//            cell?.lable.text = settingButtons[indexPath.row]
//            cell?.valueLable.isHidden = false
//            guard let time = waterModel.getUserSettings()?.startDayInterval else { return UITableViewCell() }
//            let newTime = UserSettings.convertInterval(interval: time)
//            cell?.valueLable.text = newTime
//        default:
//            cell?.lable.text = settingButtons[indexPath.row]
//        }
//        
//        return cell ?? UITableViewCell()
//    }
}



//extension SettingsTableViewController {
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0:
//            performSegue(withIdentifier: "aim", sender: self)
//        case 1:
//            performSegue(withIdentifier: "showPeriod", sender: self)
//        case 2:
//            print("Уведомления")
//        case 3:
//            resetAlert()
//            print("Сброс")
//        default:
//            return
//        }
//    }
//}



extension SettingsTableViewController {
    
    private func resetAlert() {
        
        let alertController = UIAlertController(title: "Reset", message: "Do you want to reset settings", preferredStyle: .alert)
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
    
