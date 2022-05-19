//
//  StartingTimeViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.04.2022.
//

import Foundation
import UIKit


class StartingTimeViewController: UIViewController {
    
    
    private var currentPeriod: String?
    private var waterModel = WaterModel()
    
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timeLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCurrentPeriod()
        updateLable()
    }
    
    
    @IBAction func didSetTime(_ sender: Any) {

        updateInterval(time: datePicker.date)
    }
}


extension StartingTimeViewController {
    
    private func updateInterval(time: Date) {
        
        let newInterval = UserSettings.calculateStartDayInterval(setDate: time)
        var settings = getCurrentSettings()
        settings.startDayInterval = newInterval
        waterModel.editSettings(newSettings: settings)
        let newTime = UserSettings.convertInterval(interval: newInterval)
        currentPeriod = newTime
        updateLable()
    }
    
    
    private func updateLable() {
    
        self.timeLable.text = currentPeriod
    }
    
    private func updateCurrentPeriod() {
        guard let inerval = getCurrentSettings().startDayInterval else { return }
        currentPeriod = UserSettings.convertInterval(interval: inerval)
    }
    
    private func getCurrentSettings() -> UserSettings {
        guard let settings = waterModel.getUserSettings() else { return UserSettings() }
        
        return settings
    }
}
