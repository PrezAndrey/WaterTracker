//
//  DateService.swift
//  WaterTracker
//
//  Created by Андрей  on 24.12.2022.
//

import UIKit


class DateService {
    
    let dateFormatter = DateFormatter()
    
    func convertDateToStringForSection(_ date: Date) -> String {
        dateFormatter.dateFormat = "EEEE, d MMMM"
        let convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
    
    func convertStringToDate(_ string: String) -> Date {
        guard let date = dateFormatter.date(from: string) else { return Date() }
        
        return date
    }
    
   func convertDateToString(_ date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm"
        let convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
    
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
    
    func calculateStartDayInterval(setDate date: Date) -> Double {
        var newDate = date
        let calendar = Calendar.current
        if date > Date() {
            newDate = date.addingTimeInterval(-24 * 60 * 60)
        }
        let start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: newDate)!
        let timeInterval = newDate.timeIntervalSince(start)
        
        return timeInterval
    }
    
    func intervalToDateStr(interval: TimeInterval, date: Date = Date()) -> String {
        let calendar = Calendar.current
        var start = calendar.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
        start.addTimeInterval(interval)
        if start > date {
            start = start.addingTimeInterval(-24 * 60 * 60)
        }
        let result = convertDateToString(start)
        
        return result
    }
}
