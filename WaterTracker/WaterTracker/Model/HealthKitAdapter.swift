//
//  hk.swift
//  WaterTracker
//
//  Created by Андрей  on 11.03.2022.
//

import Foundation
import HealthKit

// HealthKitAdapter - работает с HealthKit

class HealthKitAdapter {
    
     enum HealthKitAdapterError: Error {
        case dataIsNotAvailable, deviceNotAvailable
        
    }
    
    static let shared: HealthKitAdapter = HealthKitAdapter()
     
    static let store = HKHealthStore()
     
    private let objectTypes: [HKObjectType] = [
        HKObjectType.quantityType(forIdentifier: .dietaryWater),
        HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
        HKObjectType.characteristicType(forIdentifier: .biologicalSex),
        HKObjectType.characteristicType(forIdentifier: .bloodType)
     ].compactMap({ $0 })
    
    
    func getAuthorization(completion: @escaping (Bool, Error?) -> Void) {
    
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthKitAdapterError.deviceNotAvailable)
            return
        }

        guard
            let water = HKObjectType.quantityType(forIdentifier: .dietaryWater),
            let dob = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
            let sex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
            let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
            let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
            let height = HKObjectType.quantityType(forIdentifier: .height)
        else {
            completion(false, HealthKitAdapterError.dataIsNotAvailable)
            
            return
        }
        
        let writing: Set<HKSampleType> = [water, bodyMass, height]
        let reading: Set<HKObjectType> = [water, dob, sex, bloodType, bodyMass, height]
            
        HKHealthStore().requestAuthorization(toShare: writing, read: reading, completion: completion)
    }
      
    
    func authorizeIfNeeded() {
        var typesWithoutAuth: [HKObjectType] = []
        for objectType in objectTypes {
            
            let status = HealthKitAdapter.store.authorizationStatus(for: objectType)
            
            switch status {
            case .notDetermined:
                getAuthorization { (authorized, error) in
                    guard authorized else {
                        typesWithoutAuth.append(objectType)
                        let message = "authorized failed"
                        if let error = error {
                            print("\(message) reason \(error)")
                        }
                        return
                    }
                    print("HealthKit authorized successfuly")
                }
            case .sharingAuthorized:
                continue
            case .sharingDenied:
                typesWithoutAuth.append(objectType)
            @unknown default:
                fatalError()
            }
        }
    }
    
    
        // ask for permission for every data type that we want to read and ask permissions for writing the samples.
    
        
    func getAgeSexAndBloodType() throws -> (age: Int,
                                                  biologicalSex: HKBiologicalSex,
                                            bloodType: HKBloodType, bodyMass: String) {
        
      let healthKitStore = HKHealthStore()
      do {
        //1. This method throws an error if these data are not available.
        let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
        let biologicalSex =       try healthKitStore.biologicalSex()
        let bloodType =           try healthKitStore.bloodType()
        let bodyMass =            try HKQuantityTypeIdentifier.bodyMass.rawValue
          
        //2. Use Calendar to calculate age.
        let today = Date()
        let calendar = Calendar.current
        let todayDateComponents = calendar.dateComponents([.year], from: today)
        let thisYear = todayDateComponents.year!
        let age = thisYear - birthdayComponents.year!
         
        //3. Unwrap the wrappers to get the underlying enum values.
        let unwrappedBiologicalSex = biologicalSex.biologicalSex
        let unwrappedBloodType = bloodType.bloodType
          
        return (age, unwrappedBiologicalSex, unwrappedBloodType, bodyMass)
      }
    }
    
    
    
    
    // writing water to HealthKit
    func writeWater(amount: Double) {
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
    
    
    
    
    
}
