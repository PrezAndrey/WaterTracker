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
    var notificationState: Bool?
}




// MARK: Converting and Calculating date

extension UserSettings {
    
    static let dateFormatter = DateFormatter()
    
    func period(for date: Date, interval: TimeInterval=21599) -> (from: Date, to: Date) {
        
        let calendar = Calendar.current
        let start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
        var startOfThePeriod = Date(timeInterval: interval, since: start)
        if startOfThePeriod > date {
            startOfThePeriod.addTimeInterval(-24 * 60 * 60)
        }
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
        let result = convertDateToString(start)
        
        return result
    }
    
    
    static func convertDateToString(_ date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm"
        let convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
    
    static func convertStringToDate(_ string: String) -> Date {
        guard let date = dateFormatter.date(from: string) else { return Date() }
        
        return date
    }
    
    static func convertDateToStringForSection(_ date: Date) -> String {
        dateFormatter.dateFormat = "EEEE, MMMM d"
        let convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
    
    
}
