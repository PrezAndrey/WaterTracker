//
//  WaterService.swift
//  WaterTracker
//
//  Created by Андрей През on 15.02.2022.
//

import Foundation
import HealthKit

// WaterModel - связывает хранилище и HK, хранилище данных

class WaterModel {
    
    let waterStore = WaterStore()
    
    var waterAmount: Double {
        get {
            var currentWaterArray = waterStore.getRecords()
            var currentWaterAmount = sumOfWater(currentWaterArray)
            return currentWaterAmount
        }
        set {
            var oldValue = waterStore.getRecords()
            var waterAdded = newValue - oldValue[-1].waterAmount
            let newRecord = WaterRecord(waterAmount: waterAdded, date: Date())
            waterStore.addRecord(newRecord)
            
        }
    }
    
    
    func sumOfWater(_ waterRecordArray: [WaterRecord]) -> Double {
        
        var totalWater = 0.0
        
        for water in waterRecordArray {
            totalWater += water.waterAmount
        }
        return totalWater
    }
    
    
    
    
    
    
   
    
    
    
    
    
}
