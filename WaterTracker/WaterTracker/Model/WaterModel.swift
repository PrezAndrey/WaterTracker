//
//  WaterService.swift
//  WaterTracker
//
//  Created by Андрей През on 15.02.2022.
//

import Foundation
import HealthKit



protocol WaterModelDelegate {
    
    func waterAmountDidUpdate(_ model: WaterModelProtocol)
}


protocol WaterModelProtocol {
    
    var waterAmount: Double { get }
    var delegate: WaterModelDelegate? { get set }

    func deleteLast()
    func addWater(_ amount: Double)
    func getUserSettings() -> UserSettings?
}



// WaterModel - связывает хранилище и HK, хранилище данныx
class WaterModel: WaterModelProtocol {
    
    
    var delegate: WaterModelDelegate?
    
    let waterStore = WaterStore()
    let healthKitAdapter = HealthKitAdapter()
    let calculator = WaterCalculator()
    var userSettings = UserSettings()
    var notifications = Notifications()
    var dateComponents = DateComponents()
    
    var records: [WaterRecord] {
        
        let currentWaterArray = waterStore.getRecords()
        return currentWaterArray
    }
    
    var waterAmount: Double {
        
        let currentWaterArray = records
        var newInterval = userSettings
        
        if let interval = getUserSettings() {
            
            newInterval = interval
        }
        let date = userSettings.period(for: Date(), interval: newInterval.startDayInterval ?? 21599)
        let fromDate = date.from
        let toDate = date.to
        let currentWaterAmount = calculator.sumOfWater(currentWaterArray, from: fromDate, to: toDate)
        print("###### I AM WORKING ####### WATER AMOUNT IS: \(currentWaterAmount), START DATE: \(fromDate), FINISH DATE: \(toDate), DATE: \(Date())")
        
        return currentWaterAmount
    }
    
    init() {
        
        healthKitAdapter.authorizeIfNeeded()
    }
    
    
    // MARK: Functions
    
    func deleteLast() {
        
        guard let lastRecord = records.last else { return }
        deleteRecord(record: lastRecord)
    }
    
    
    func deleteRecord(record: WaterRecord) {
        
        var currentRecordArray = waterStore.getRecords()
        for (index, value) in currentRecordArray.enumerated() {
            if value == record {
                currentRecordArray.remove(at: index)
            }
        }
        waterStore.save(record: currentRecordArray, key: Constants.waterKey)
    }
    
    
    func addWater(_ amount: Double) {
        let newRecord = WaterRecord(waterAmount: amount, date: Date())
        healthKitAdapter.writeWater(amount: amount)
        waterStore.addRecord(newRecord)
        delegate?.waterAmountDidUpdate(self)
        
        notificationRequest()
        
    }
    
    
    func editWaterAmount(_ record: WaterRecord, newAmount: Double) {
        
        var currentRecords = waterStore.getRecords()
        if let index = currentRecords.firstIndex(of: record) {
            currentRecords[index].waterAmount = newAmount
        }
        waterStore.save(record: currentRecords, key: "waterKey")
    }
    
    
    func fetchDataFromHealthKit() throws -> (HKTypes){
        let hkTypes = try healthKitAdapter.getAgeSexAndBloodType()
        
        return hkTypes
    }
    
    
    func saveUserSettings(settings: UserSettings) {
        
        waterStore.saveSettings(settings)
        userSettings.startDayInterval = settings.startDayInterval
    }
    
    
    func getUserSettings() -> UserSettings? {
        
        let settings = waterStore.getSettings()
        
        return settings
    }
    
    
    func editSettings(newSettings: UserSettings) {
        
        waterStore.saveSettings(newSettings)
       
    }
    
    
    func notificationRequest() {
        
        var settings = getUserSettings()
        let calendar = Calendar.current
        let currentHour = calendar.dateComponents([.hour], from: Date())
        notifications.checkAuthorization()
        
        switch settings?.notificationState {
        case true:

            if (14 <= currentHour.hour! && currentHour.hour! <= 16) || (19 <= currentHour.hour! && currentHour.hour! <= 23){
                print("Day Notification Works")
                notifications.scheduleTimeNotification(title: "Плановое уведомление", waterAmount: waterAmount, currentAim: settings?.dayTarget ?? 2100)
            }
        case false:
            print("Present Alert to switch on Notifications")
        default:
            print("setting are nil")
        }
       
        
    }
}
