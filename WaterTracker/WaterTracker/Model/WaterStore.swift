//
//  WaterService.swift
//  WaterTracker
//
//  Created by Андрей През on 15.02.2022.
//

import Foundation
import HealthKit

// WaterStore - отвечает за то, как хранить данные и за авторизацию HealthKit

class WaterStore: HealthKitAdapter {
    
    
    
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
