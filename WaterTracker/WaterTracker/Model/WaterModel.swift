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
    
    
    
    
    
    var records: [WaterRecord] {
        
        let currentWaterArray = waterStore.getRecords()
        return currentWaterArray
    }
    
    var waterAmount: Double {
       
        let currentWaterArray = records
        if let interval = getUserSettings() {
            let currentWaterAmount = calculator.sumOfWater(currentWaterArray, from: userSettings.period(for: Date(), interval: interval.startDayInterval ?? 21599).from, to: userSettings.period(for: Date(), interval: interval.startDayInterval ?? 21599).to)
            
            return currentWaterAmount
        }
       
        return 0
    }
    
    init() {
        
        healthKitAdapter.authorizeIfNeeded()
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
    
    
    func fetchDataFromHealthKit() throws -> (age: Int,
                                         biologicalSex: HKBiologicalSex,
                                         bloodType: HKBloodType){
        let tupleHK = try healthKitAdapter.getAgeSexAndBloodType()
        return tupleHK
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
        userSettings.startDayInterval = newSettings.startDayInterval
        
    }
    
    
    
    
}
