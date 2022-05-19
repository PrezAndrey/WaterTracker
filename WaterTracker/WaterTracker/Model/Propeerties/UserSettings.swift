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
    
    var startDayInterval: TimeInterval?
    
    var weight: Int?
    
}

// MARK: Converting and Calculating date

extension UserSettings {
    
    
    func period(for date: Date, interval: TimeInterval) -> (from: Date, to: Date) {
        let calendar = Calendar.current
        let start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
        
        let startOfThePeriod = Date(timeInterval: interval, since: start)
        print("Start day interval from function period is: \(interval)")
        let endOfThePeriod = Date(timeInterval: 24 * 60 * 60, since: startOfThePeriod)
        
        return (startOfThePeriod, endOfThePeriod)
    }
    
    static func calculateStartDayInterval(setDate date: Date) -> Double {
        
        let calendar = Calendar.current
        let start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
        let timeInterval = date.timeIntervalSince(start)
        
        return timeInterval
    }
    
    static func convertInterval(interval: TimeInterval, date: Date = Date()) -> String {
        
        let calendar = Calendar.current
        var start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
        start.addTimeInterval(interval)
        let result = convertDate(start)
        
        return result
    }
    
    static func convertDate(_ date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
}
