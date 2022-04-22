//
//  WaterSettings.swift
//  WaterTracker
//
//  Created by Андрей През on 09.03.2022.
//

import Foundation

enum Sex: Codable {
    case notSet

    case female 
    
    case male
    
    case other
}

struct UserSettings: Codable, Equatable {

    
    var dayTarget: Int?
    
    var startDayInterval: TimeInterval?  //21599
    
    
    //var dateOfBirth: Date
    
    //var sex: Sex
    
    var height: Int?
    
    var weight: Int?
    
    
    
//    init(dayTarget: Int, startDayInterval: TimeInterval, height: Int, weight: Int) {
//        self.startDayInterval = startDayInterval
//        self.dayTarget = dayTarget
//        self.height = height
//        self.weight = weight
//    }
}

extension UserSettings {
    func period(for date: Date) -> (from: Date, to: Date) {
        let calendar = Calendar.current
        let start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
        
        let startOfThePeriod = Date(timeInterval: startDayInterval ?? 21599, since: start)
        let endOfThePeriod = Date(timeInterval: 86401, since: startOfThePeriod)
        
        return (startOfThePeriod, endOfThePeriod)
        
        
    }
    
    func calculateStartDayInterval(setDate: Date) -> Double {
        let calendar = Calendar.current
        let start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: Date())!
        let timeInterval = setDate.timeIntervalSince(start)
        return timeInterval
    }
}
