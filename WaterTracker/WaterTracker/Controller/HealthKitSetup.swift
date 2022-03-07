//
//  HealthKitSetup.swift
//  WaterTracker
//
//  Created by Андрей През on 08.02.2022.
//

import Foundation
import HealthKit


class HealthKitAdapter {
    
    enum HealthKitSetupError: Error {
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
    
    
//    // writing water to HealthKit
////    func writeWater(amount: Double) {
////        guard let waterType = HKSampleType.quantityType(forIdentifier: .dietaryWater) else {
////                print("Sample type not available")
////                return
////            }
////
////            let waterQuantity = HKQuantity(unit: HKUnit.literUnit(with: .milli), doubleValue: amount)
////            let today = Date()
////            let waterQuantitySample = HKQuantitySample(type: waterType, quantity: waterQuantity, start: today, end: today)
////
////            store.save(waterQuantitySample) { (success, error) in
////                print("HK write finished - success: \(success); error: \(error)")
//
//            }
//    }
    
    // Checking authorization status
    func authorizeIfNeeded() {
//    func checkAuthorization() {
        
        
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
        
        // do something with typesWithoutAuth
        
        
    }
    
    // ask for permission for every data type that we want to read and ask permissions for writing the samples.
    private func getAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        
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
    
}


//class HealthKitSetup {
//
//     enum HealthKitSetupError: Error {
//        case dataIsNotAvailable, deviceNotAvailable
//
//    }
//
//    // HealthKit Status
//    static var notWorking: Bool = true
//
//
//    // ask for permission for every data type that we want to read and ask permissions for writing the samples.
//    class func getAuthorization(completion: @escaping (Bool, Error?) -> Void) {
//
//        guard HKHealthStore.isHealthDataAvailable() else {
//            completion(false, HealthKitSetupError.deviceNotAvailable)
//            return
//        }
//
//        guard
//            let water = HKObjectType.quantityType(forIdentifier: .dietaryWater),
//            let dob = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
//            let sex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
//            let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType)
//        else {
//            completion(false, HealthKitSetupError.dataIsNotAvailable)
//
//            return
//        }
//
//        let writing: Set<HKSampleType> = [water]
//        let reading: Set<HKObjectType> = [water, dob, sex, bloodType]
//
//        HKHealthStore().requestAuthorization(toShare: writing, read: reading, completion: completion)
//        self.notWorking = false
//
//
//    }
//    // writing water to HealthKit
//    class func writeWater(amount: Double) {
//        guard let waterType = HKSampleType.quantityType(forIdentifier: .dietaryWater) else {
//                print("Sample type not available")
//                return
//            }
//
//            let waterQuantity = HKQuantity(unit: HKUnit.literUnit(with: .milli), doubleValue: amount)
//            let today = Date()
//            let waterQuantitySample = HKQuantitySample(type: waterType, quantity: waterQuantity, start: today, end: today)
//
//            HKHealthStore().save(waterQuantitySample) { (success, error) in
//                print("HK write finished - success: \(success); error: \(error)")
//
//            }
//    }
//
//    // Checking authorization status
//    class func checkAuthorization() {
//        if self.notWorking  {
//            HealthKitSetup.getAuthorization { (authorized, error) in
//                guard authorized else {
//                    let message = "authorized failed"
//                    if let error = error {
//                        print("\(message) reason \(error)")
//                    }
//                    return
//                }
//                print("HealthKit authorized successfuly")
//            }
//        }
//    }
//
////    class func readCharacteristicsData() {
////        let store = HKHealthStore()
////        do {
////            let dobComponents = try store.dateOfBirthComponents()
////            let sex = try store.biologicalSex().biologicalSex
////
////            DispatchQueue.main.async {
////                self.dobLabel.text = "DOB: \(dobComponents.day!)/\(dobComponents.month!)/\(dobComponents.year!)"
////                self.sexLable.text = "Sex: \(sex.rawValue)"
////            }
////        } catch {
////            print("Something went wrong: \(error)")
////        }
////    }
//}
