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

    var dayTarget: Int? = 2000
    var startDayInterval: TimeInterval? = 21599
    var weight: Int? 
}




// MARK: Converting and Calculating date

extension UserSettings {
    
    static let dateFormatter = DateFormatter()
    
    func period(for date: Date, interval: TimeInterval=21599) -> (from: Date, to: Date) {
        
        var calendar = Calendar.current
        let start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
        print("START TIME: \(start)")
        var startOfThePeriod = Date(timeInterval: interval, since: start)
        if startOfThePeriod > date {
            startOfThePeriod.addTimeInterval(-24 * 60 * 60)
        }
        print("Start day interval from function period is: \(interval)")
        print("Start day TIME from function period is: \(startOfThePeriod)")
        let endOfThePeriod = Date(timeInterval: 24 * 60 * 60, since: startOfThePeriod)
        
        return (startOfThePeriod, endOfThePeriod)
    }
    
    
    static func calculateStartDayInterval(setDate date: Date) -> Double {
        var newDate = date
        let calendar = Calendar.current
        if date > Date() {
            newDate = date.addingTimeInterval(-24 * 60 * 60)
        }
        let start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: newDate)!
        let timeInterval = newDate.timeIntervalSince(start)
        
        return timeInterval
    }
    
    
    static func convertInterval(interval: TimeInterval, date: Date = Date()) -> String {
        
        let calendar = Calendar.current
        var start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
        start.addTimeInterval(interval)
        if start > date {
            start = start.addingTimeInterval(-24 * 60 * 60)
        }
        let result = convertDate(start)
        
        return result
    }
    
    
    static func convertDate(_ date: Date) -> String {
        
        
        dateFormatter.dateFormat = "HH:mm"
        let convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
}
