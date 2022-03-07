//
//  Model.swift
//  WaterTracker
//
//  Created by Андрей През on 21.12.2021.
//

import Foundation

// WaterModel - отвечает за данные, производит вычисления

class WaterModel {
    
    static var model = WaterModel()
    
    
    
    // MARK: Constants
    struct Constants {
        static let defaultAmountOfWater: Int = 0
        static let defaultUndoValue: Int = 0
        
        enum Keys: String {
            case waterAmountKey = "waterKey"
        }
        
    
    }
    
    
    var amountOfWater: Int {
        get {
            return WaterModel.model.get(key: Constants.Keys.waterAmountKey.rawValue) as? Int ?? Constants.defaultAmountOfWater
        }
        set {
            WaterModel.model.save(element: newValue, forKey: Constants.Keys.waterAmountKey.rawValue)
        }
    }
    
    private func save(element: Any?, forKey: String) {
        UserDefaults.standard.set(element, forKey: forKey)
    }
    
    private func get(key: String) -> Any? {
        let data = UserDefaults.standard.object(forKey: key)
        return data
    }
}
