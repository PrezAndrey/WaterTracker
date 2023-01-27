//
//  DayTargetCollectionViewCell.swift
//  WaterTracker
//
//  Created by Андрей  on 28.01.2023.
//

import UIKit

class DayTargetCollectionViewCell: UICollectionViewCell {
    
    
    private let waterModel = WaterModel()
    
    @IBOutlet weak var dayTarget: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    private func configureTarget() {
        var settings = UserSettings(dayTarget: 0, startDayInterval: 21599, weight: 0, notificationState: false)
        if let existingSettings = waterModel.getUserSettings() {
            settings = existingSettings
        } else {
            waterModel.saveUserSettings(settings: settings)
        }
        dayTarget.text = "\(settings.dayTarget ?? 0) ml"
    }
    
    func configureView() {
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 2
        cellView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        dayTarget.layer.borderWidth = 2
        dayTarget.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        dayTarget.layer.cornerRadius = 10
        
        configureTarget()
    }
}
