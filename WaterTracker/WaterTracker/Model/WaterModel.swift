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


class WaterModel: WaterModelProtocol {

    var delegate: WaterModelDelegate?
    let waterStore = WaterStore()
    let healthKitAdapter = HealthKitAdapter()
    let calculator = WaterCalculator()
    var userSettings = UserSettings()
    var notifications = Notifications()
    let dateService = DateService()
    private var requestNumber = 0
    
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
        print("UserSettings on start: \(newInterval)")
        let date = dateService.period(for: Date(), interval: newInterval.startDayInterval ?? 21599)
        let fromDate = date.from
        let toDate = date.to
        let currentWaterAmount = calculator.sumOfWater(currentWaterArray, from: fromDate, to: toDate)
        
        return currentWaterAmount
    }
    
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
    }
    
    func editWaterAmount(_ record: WaterRecord, newAmount: Double) {
        var currentRecords = waterStore.getRecords()
        if let index = currentRecords.firstIndex(of: record) {
            currentRecords[index].waterAmount = newAmount
        }
        waterStore.save(record: currentRecords, key: "waterKey")
    }
    
    func fetchDataFromHealthKit() throws -> HKTypes {
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
}
