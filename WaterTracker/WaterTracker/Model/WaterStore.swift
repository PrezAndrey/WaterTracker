//
//  Model.swift
//  WaterTracker
//
//  Created by Андрей През on 21.12.2021.
//

import Foundation

// WaterStore - хранение и обработка данных


class WaterStore: Codable {
    
    static var model = WaterStore()
    
    
    
    
    
    
    // MARK: Constants
    
    struct Constants {
        static let defaultAmountOfWater: Int = 0
        static let defaultUndoValue: Int = 0

        static let waterKey = "waterKey"
        static let userSettingsKey = "userSettingsKey"


    }
    
    // MARK: Functions
    
    
    
    
    func save(record: [WaterRecord], key: String) {
        if let data = try? PropertyListEncoder().encode(record) {
            UserDefaults.standard.set(data, forKey: key)
        }
        
    }
    
    func get(key: String) -> [WaterRecord] {
        if let data = UserDefaults.standard.data(forKey: key) {
            let array = try! PropertyListDecoder().decode([WaterRecord].self, from: data)
            return array
        }
        return []
    }
    
    func  delete(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    
    
    
    // Создать методы интерфейса, которые получают список WR: Добавить, удалить, изменить, получить WaterRecord запись
    func addRecord(_ record: WaterRecord) {
        
        var currentRecordArray = getRecords()
        
        currentRecordArray.append(record)
        
        save(record: currentRecordArray, key: Constants.waterKey)
        
        
        
    }
    
    func deleteRecord() {
        var currentRecordArray = get(key: Constants.waterKey)
        if currentRecordArray.isEmpty {
            return
        }
        else {
            currentRecordArray.removeLast()
            save(record: currentRecordArray, key: Constants.waterKey)
            
        }
        
        
    }
    
    func editRecord(_ record: WaterRecord) {
        
    }
    
    func getRecords() -> [WaterRecord] {
        var waterArray = get(key: Constants.waterKey)
        
        if waterArray.isEmpty {
            waterArray = [WaterRecord(waterAmount: 0, date: Date())]
            return waterArray
        }
        else {
            return waterArray
        }
        
    }
    
    
    
    // Создать два метода, на чтение и запись текущих настроек
    
    func saveSettings(_ settings: UserSettings) {
        if let data = try? PropertyListEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: Constants.userSettingsKey)
        }
    }
    
    func getSettings() -> UserSettings? {
        if let data = UserDefaults.standard.data(forKey: Constants.userSettingsKey) {
            let settings = try! PropertyListDecoder().decode(UserSettings.self, from: data)
            return settings
        }
        return nil
    }
}
