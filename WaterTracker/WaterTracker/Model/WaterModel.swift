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
    
    
    
    // writing water to HealthKit
    func writeWater(amount: Double) {
        guard let waterType = HKSampleType.quantityType(forIdentifier: .dietaryWater) else {
                print("Sample type not available")
                return
            }
            
            let waterQuantity = HKQuantity(unit: HKUnit.literUnit(with: .milli), doubleValue: amount)
            let today = Date()
            let waterQuantitySample = HKQuantitySample(type: waterType, quantity: waterQuantity, start: today, end: today)
            
        store.save(waterQuantitySample) { (success, error) in
                print("HK write finished - success: \(success); error: \(error)")
                
            }
    }
    
    
    
   
    
    
    
    
    
}
