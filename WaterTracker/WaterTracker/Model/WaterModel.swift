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
    
    func deleteChosen(_ record: WaterRecord?, last: Bool)
    func addWater(_ amount: Double)
    
}

// WaterModel - связывает хранилище и HK, хранилище данныx
class WaterModel: WaterModelProtocol {
    
    var delegate: WaterModelDelegate?
    
    
    let waterStore = WaterStore()
    let healthKitAdapter = HealthKitAdapter()
    let calculator = WaterCalculator()
    let userSettings = UserSettings()
    
    var records: [WaterRecord] {
        let currentWaterArray = waterStore.getRecords()
        return currentWaterArray
    }
    
    var waterAmount: Double {
       
        let currentWaterArray = records
        var currentWaterAmount = calculator.sumOfWater(currentWaterArray, from: userSettings.startDayInterval.from, to: userSettings.startDayInterval.to)
        return currentWaterAmount
        
        
    }
    
    init() {
        healthKitAdapter.authorizeIfNeeded()
        
        
    }
    
    func deleteChosen(_ record: WaterRecord?, last: Bool) {
        if last && record == nil {
            var array = records
            array.removeLast()
            waterStore.save(record: array, key: "waterKey")
            delegate?.waterAmountDidUpdate(self)
        }
        else {
            waterStore.deleteRecord(record: record!)
            
        }
    }
    
    func addWater(_ amount: Double) {
        let newRecord = WaterRecord(waterAmount: amount, date: Date())
        waterStore.addRecord(newRecord)
        delegate?.waterAmountDidUpdate(self)
    }
    
    func editWaterAmount(_ record: WaterRecord, newAmount: Double) {
        var currentRecords = waterStore.getRecords()
        
        
        for (index, value) in currentRecords.enumerated() {
            if value == record {
                currentRecords[index].waterAmount = newAmount
            }
        }
        waterStore.save(record: currentRecords, key: "waterKey")
    }
    
    
    
    
}
