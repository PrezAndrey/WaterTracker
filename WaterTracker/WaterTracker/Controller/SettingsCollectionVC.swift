//
//  SettingsCollectionVC.swift
//  WaterTracker
//
//  Created by Андрей  on 09.05.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class SettingsCollectionVC: UICollectionViewController {
    
    private let waterModel = WaterModel()
    
    let actions = ["Авто-цель", "Настройка периода", "HealthKit", "Уведомления", "Сброс настроек"]

   
    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SettingsCollectionViewCell
        
        cell.lable.text = actions[indexPath.row]
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        
        switch action {
        case "Авто-цель":
            performSegue(withIdentifier: "ShowAutoAim", sender: self)
        case "Настройка периода":
            performSegue(withIdentifier: "openPicker", sender: self)
        case "HealthKit":
            print("HealthKit")
        case "Уведомления":
            print("Уведомления")
        case "Сброс настроек":
            resetAlert()
        default:
            break
        }
    }

}



// MARK: Reset settings

extension SettingsCollectionVC {
    
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
        
        let newSettings = UserSettings(dayTarget: 0, startDayInterval: 21599, weight: 0)
        waterModel.editSettings(newSettings: newSettings)
        
    }
}
