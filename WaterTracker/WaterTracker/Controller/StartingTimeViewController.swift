//
//  StartingTimeViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.04.2022.
//


import UIKit

class StartingTimeViewController: UIViewController {
    
    private var currentPeriod: String?
    private var waterModel = WaterModel()
    private let dateService = DateService()
    
    var completion: ((String) -> Void)?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var setButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateCurrentPeriod()
        updateLable()
    }
    
    @IBAction func didSetTime(_ sender: Any) {
        print(datePicker.date)
        updateInterval(time: datePicker.date)
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: Update functions
extension StartingTimeViewController {
    
    func updateInterval(time: Date) {
        let newInterval = dateService.calculateStartDayInterval(setDate: time)
        var settings = getCurrentSettings()
        settings.startDayInterval = newInterval
        waterModel.editSettings(newSettings: settings)
        let newTime = dateService.intervalToDateStr(interval: newInterval)
        currentPeriod = newTime
        completion?(newTime)
        updateLable()
    }
    
    private func updateLable() {
        self.timeLable.text = currentPeriod
    }
    
    private func updateCurrentPeriod() {
        let inerval = getCurrentSettings().startDayInterval ?? 0
        currentPeriod = dateService.intervalToDateStr(interval: inerval)
    }
    
    private func getCurrentSettings() -> UserSettings {
        guard let settings = waterModel.getUserSettings() else { return UserSettings() }
        
        return settings
    }
}

extension StartingTimeViewController {
    
    func configureUI() {
        timeLable.layer.cornerRadius = 5
        timeLable.layer.borderWidth = 2
        timeLable.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        
        setButtonLabel.layer.cornerRadius = 5
        setButtonLabel.layer.borderWidth = 2
        setButtonLabel.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor

    }
}
