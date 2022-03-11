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

        static let waterKey = "waterKey"
        static let userSettingsKey = "userSettingsKey"


    }
    
    
    var amountOfWater: Int {
        get {
            return WaterStore.model.get(key: Constants.waterKey) as? Int ?? Constants.defaultAmountOfWater
        }
        set {
            //WaterStore.model.save(element: newValue, key: Constants.Keys.waterAmountKey.rawValue)
        }
    }
    
    func save(element: [Any]?, key: String) {
        UserDefaults.standard.set(element, forKey: key)
    }
    
    func get(key: String) -> [WaterRecord]? {
        var data = UserDefaults.standard.object(forKey: key)
        return data as! [WaterRecord]
    }
    
    func  delete(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    
    
    
    // Создать методы интерфейса, которые получают список WR: Добавить, удалить, изменить, получить WaterRecord запись
    func addRecord(_ record: WaterRecord) {
        // проверяем возвращается ли массив по ключу, если нет, то создаем и сохраняем
        if var waterRecordArray = get(key: Constants.waterKey) {
            waterRecordArray.append(record)
        } else {
            var waterRecordArray: [WaterRecord] = []
            save(element: waterRecordArray, key: Constants.waterKey)
        }
        // по ключу достаем массив со всеми записями, добавляем в массив новую запись и сохранить в UD с помощью set  по ключу
    }
    
    func deleteRecord(_ record: WaterRecord) {
        var waterRecordArray = get(key: Constants.waterKey) ?? [WaterRecord]()
        if waterRecordArray.isEmpty {
            return
        }
        else {
            waterRecordArray.removeLast()
            save(element: waterRecordArray, key: Constants.waterKey)
        }
        
    }
    
    func editRecord(_ record: WaterRecord) {
        
    }
    
    func getRecords() -> [WaterRecord] {
        var waterArray = get(key: Constants.waterKey) ?? [WaterRecord]()
        
        return waterArray
    }
    
    
    
    // Создать два метода, на чтение и запись текущих настроек
    
    func saveSettings(_ settings: UserSettings) {
        UserDefaults.standard.set(settings, forKey: Constants.userSettingsKey)
    }
    
    func getSettings() -> UserSettings? {
        var userSettings = UserDefaults.standard.object(forKey: Constants.userSettingsKey)
        return userSettings as! UserSettings
    }
}
