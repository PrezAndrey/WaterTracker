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

    
    var dayTarget = 2000
    
    var startDayInterval: TimeInterval = 21599
    
    var dateOfBirth: Date?
    
    var sex: Sex?
    
    var height = 175
    
    var weight = 75
    
    
}

extension UserSettings {
    func period(for date: Date) -> (from: Date, to: Date) {
        let calendar = Calendar.current
        let start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
        
        let startOfThePeriod = Date(timeInterval: startDayInterval, since: start)
        let endOfThePeriod = Date(timeInterval: 86401, since: startOfThePeriod)
        
        return (startOfThePeriod, endOfThePeriod)
        
        
    }
}
