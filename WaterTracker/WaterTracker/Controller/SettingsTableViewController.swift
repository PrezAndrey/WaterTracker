//
//  SettingsTableViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.05.2022.
//

import UIKit



class SettingsTableViewController: UITableViewController {
    
    let settingButtons = ["Авто-цель", "Настройка периода", "Уведомления", "Сброс настроек"]
    private let waterModel = WaterModel()
}



// MARK: - Table view data source

extension SettingsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settingButtons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as? SettingCell
        
        switch indexPath.row {
        case 0:
            guard let aim = waterModel.getUserSettings()?.dayTarget else { return UITableViewCell() }
            cell?.lable.text = settingButtons[indexPath.row]
            cell?.valueLable.isHidden = false
            cell?.valueLable.text = String(aim)
        case 1:
            cell?.lable.text = settingButtons[indexPath.row]
            cell?.valueLable.isHidden = false
            guard let time = waterModel.getUserSettings()?.startDayInterval else { return UITableViewCell() }
            let newTime = UserSettings.convertInterval(interval: time)
            cell?.valueLable.text = newTime
        default:
            cell?.lable.text = settingButtons[indexPath.row]
        }
        
        return cell ?? UITableViewCell()
    }
}



extension SettingsTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "aim", sender: self)
        case 1:
            performSegue(withIdentifier: "showPeriod", sender: self)
        case 2:
            print("Уведомления")
        case 3:
            resetAlert()
            print("Сброс")
        default:
            return
        }
    }
}



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
    }
}
    
