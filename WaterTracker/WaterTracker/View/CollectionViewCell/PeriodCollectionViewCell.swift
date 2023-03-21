//
//  PeriodCollectionViewCell.swift
//  WaterTracker
//
//  Created by Андрей  on 28.01.2023.
//

import UIKit


class PeriodCollectionViewCell: UICollectionViewCell {
    
    private let waterModel = WaterModel()
    private let dateService = DateService()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    private func configureUI() {
        var settings = UserSettings(dayTarget: 0, startDayInterval: 21599, weight: 0, notificationState: false)
        if let existingSettings = waterModel.getUserSettings() {
            settings = existingSettings
        } else {
            waterModel.saveUserSettings(settings: settings)
        }
        let newTime = dateService.intervalToDateStr(interval: settings.startDayInterval ?? 21599)
        timeLabel.text = "\(newTime)"
    }
    
    func configureView() {
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 2
        cellView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        timeLabel.layer.borderWidth = 2
        timeLabel.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        timeLabel.layer.cornerRadius = 10
    }
}
