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
        print(datePicker.date)
        updateInterval(time: datePicker.date)
    }
}


// MARK: Update functions

extension StartingTimeViewController {
    
    func updateInterval(time: Date) {
        
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
        
        let inerval = getCurrentSettings().startDayInterval ?? 0
        currentPeriod = UserSettings.convertInterval(interval: inerval)
    }
    
    
    private func getCurrentSettings() -> UserSettings {
        guard let settings = waterModel.getUserSettings() else { return UserSettings() }
        
        return settings
    }
}
