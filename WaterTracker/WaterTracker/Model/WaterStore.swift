//
//  Model.swift
//  WaterTracker
//
//  Created by Андрей През on 21.12.2021.
//

import Foundation

// WaterStore - хранение и обработка данных

class WaterStore {
    
    static var model = WaterStore()
    
    
    
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
            return WaterStore.model.get(key: Constants.Keys.waterAmountKey.rawValue) as? Int ?? Constants.defaultAmountOfWater
        }
        set {
            WaterStore.model.save(element: newValue, forKey: Constants.Keys.waterAmountKey.rawValue)
        }
    }
    
    private func save(element: Any?, forKey: String) {
        UserDefaults.standard.set(element, forKey: forKey)
    }
    
    private func get(key: String) -> Any? {
        let data = UserDefaults.standard.object(forKey: key)
        return data
    }
    
    
    // Создать методы интерфейса, которые получают список WR: Добавить, удалить, изменить, получить WaterRecord запись
    func addRecord(_ record: WaterRecord) {
        // по ключу достаем массив со всеми записями, добавляем в массив новую запись и сохранить в UD с помощью set  по ключу
    }
    
    func deleteRecord(_ record: WaterRecord) {
        
    }
    
    func editRecord(_ record: WaterRecord) {
        
    }
    
    func getRecords() -> [WaterRecord] {
        
        return []
    }
    
    
    
    // Создать два метода, на чтение и запись текущих настроек
    
    func saveSettings(_ settings: UserSettings) {
        
    }
    
    func getSettings() -> UserSettings? {
        
        return nil
    }
}
