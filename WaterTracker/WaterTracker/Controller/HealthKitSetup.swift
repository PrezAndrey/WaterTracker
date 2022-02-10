//
//  HealthKitSetup.swift
//  WaterTracker
//
//  Created by Андрей През on 08.02.2022.
//

import Foundation
import HealthKit

class HealthKitSetup {
    
     enum HealthKitSetupError: Error {
        case dataIsNotAvailable, deviceNotAvailable
        
    }
    
    
    // ask for permission for every data type that we want to read and ask permissions for writing the samples.
    class func getAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthKitSetupError.deviceNotAvailable)
            return
        }
        
        guard
            let water = HKObjectType.quantityType(forIdentifier: .dietaryWater),
            let dob = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
            let sex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
            let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType)
        else {
            completion(false, HealthKitSetupError.dataIsNotAvailable)
            
            return
        }
        
        let writing: Set<HKSampleType> = [water]
        let reading: Set<HKObjectType> = [water, dob, sex, bloodType]
        
        HKHealthStore().requestAuthorization(toShare: writing, read: reading, completion: completion)
        
        
    }
    
    class func writeWater(amount: Double) {
        guard let waterType = HKSampleType.quantityType(forIdentifier: .dietaryWater) else {
                print("Sample type not available")
                return
            }
            
            let waterQuantity = HKQuantity(unit: HKUnit.literUnit(with: .milli), doubleValue: amount)
            let today = Date()
            let waterQuantitySample = HKQuantitySample(type: waterType, quantity: waterQuantity, start: today, end: today)
            
            HKHealthStore().save(waterQuantitySample) { (success, error) in
                print("HK write finished - success: \(success); error: \(error)")
                
            }
    }
    
//    class func readCharacteristicsData() {
//        let store = HKHealthStore()
//        do {
//            let dobComponents = try store.dateOfBirthComponents()
//            let sex = try store.biologicalSex().biologicalSex
//            
//            DispatchQueue.main.async {
//                self.dobLabel.text = "DOB: \(dobComponents.day!)/\(dobComponents.month!)/\(dobComponents.year!)"
//                self.sexLable.text = "Sex: \(sex.rawValue)"
//            }
//        } catch {
//            print("Something went wrong: \(error)")
//        }
//    }
}
