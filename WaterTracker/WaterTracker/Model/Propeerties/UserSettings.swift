//
//  WaterSettings.swift
//  WaterTracker
//
//  Created by Андрей През on 09.03.2022.
//

import Foundation

enum Sex: Codable {
    case male

    case female
}

struct UserSettings: Codable, Equatable {

    
    var dayTarget: Double?
    
    var startDayInterval: (from: Date, to: Date) {
        return period(for: Date())
    }
    
    var dateOfBirth: Date?
    
    var sex: Sex?
    
    var height: Double?
    
    var weight: Double?
    
    
}

extension UserSettings {
    func period(for date: Date) -> (from: Date, to: Date) {
        let calendar = Calendar.current
        
        let startOfThePeriod = calendar.date(bySettingHour: 5, minute: 59, second: 59, of: date)!
        let endOfThePeriod = Date(timeInterval: 86401, since: startOfThePeriod)
        
        return (startOfThePeriod, endOfThePeriod)
        
        
    }
}
