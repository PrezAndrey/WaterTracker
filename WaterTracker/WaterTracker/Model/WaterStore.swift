//
//  Model.swift
//  WaterTracker
//
//  Created by Андрей През on 21.12.2021.
//

import Foundation

struct Constants {
    
    static let defaultAmountOfWater: Int = 0
    static let defaultUndoValue: Int = 0
    static let waterKey = "waterKey"
    static let userSettingsKey = "userSettingsKey"
}

class WaterStore: Codable {
    
    static var model = WaterStore()
    
    func save(record: [WaterRecord], key: String) {
        if let data = try? PropertyListEncoder().encode(record) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func get(key: String) -> [WaterRecord] {
        if let data = UserDefaults.standard.data(forKey: key) {
            let array = try? PropertyListDecoder().decode([WaterRecord].self, from: data)
            return array ?? []
        }
        return []
    }
    
    func  delete(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func addRecord(_ record: WaterRecord) {
        var currentRecordArray = getRecords()
        currentRecordArray.append(record)
        save(record: currentRecordArray, key: Constants.waterKey)
    }
    
    func deleteRecord(record: WaterRecord) {
        var currentRecordArray = get(key: Constants.waterKey)
        for (index, value) in currentRecordArray.enumerated() {
            if value == record {
                currentRecordArray.remove(at: index)
            }
        }
        save(record: currentRecordArray, key: Constants.waterKey)
    }

    func getRecords() -> [WaterRecord] {
        let waterArray = get(key: Constants.waterKey)
        
        return waterArray
    }
    
    func saveSettings(_ settings: UserSettings) {
        if let data = try? PropertyListEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: Constants.userSettingsKey)
        }
    }
    
    func getSettings() -> UserSettings? {
        if let data = UserDefaults.standard.data(forKey: Constants.userSettingsKey) {
            let settings = try? PropertyListDecoder().decode(UserSettings.self, from: data)
            return settings
        }
        return nil
    }
}
