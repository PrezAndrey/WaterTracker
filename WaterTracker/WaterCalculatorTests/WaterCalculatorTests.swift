//
//  WaterCalculatorTests.swift
//  WaterCalculatorTests
//
//  Created by Андрей  on 14.04.2022.
//

import XCTest

@testable import WaterTracker

class WaterCalculatorTests: XCTestCase {

    var userSettings: UserSettings!
    var calculator: WaterCalculator!
    
    
    override func setUpWithError() throws {
        userSettings = UserSettings()
        calculator = WaterCalculator()
    }

    override func tearDownWithError() throws {
        userSettings = nil
        calculator = nil
        
    }
    
    func testEmptyRecordSum() throws {
        
        
        let records: [WaterRecord] = []
        
        let date = Date()
        let period = userSettings.startDayInterval
        let result = calculator.sumOfWater(records, from: period.from, to: period.to)
        
        
        XCTAssertEqual(result, 0.0)
    }
    
    
    func testOneRecordSum() throws {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        
        let records: [WaterRecord] = [
            WaterRecord(waterAmount: 100.0, date: dateFormatter.date(from: "2022-03-17 12:22")!)
        ]
        let startDate = dateFormatter.date(from: "2022-03-17 06:00")!
        let endDate = dateFormatter.date(from: "2022-03-18 05:59")!
        
        let result = calculator.sumOfWater(records, from: startDate, to: endDate)
        
        XCTAssertEqual(result, 100.0)
        
    }
    
    
    func testOneDayOutsidePeriodSum() throws {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        
        let records: [WaterRecord] = [
            WaterRecord(waterAmount: 100.0, date: dateFormatter.date(from: "2022-02-17 12:22")!)
        ]
        let startDate = dateFormatter.date(from: "2022-03-17 06:00")!
        let endDate = dateFormatter.date(from: "2022-03-18 05:59")!
        
        let result = calculator.sumOfWater(records, from: startDate, to: endDate)
        
        XCTAssertEqual(result, 0.0)
        
    }
    
    
    func testBoarderPeriod() throws {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        
        let records: [WaterRecord] = [
            WaterRecord(waterAmount: 100.0, date: dateFormatter.date(from: "2022-04-16 05:59:59")!)
        ]
        let period = userSettings.startDayInterval
        let startDate = period.from
        let endDate = period.to
        
        let result = calculator.sumOfWater(records, from: startDate, to: endDate)
        
        XCTAssertEqual(result, 100.0)
        
    }
    
    
    func testTwoRecordsWithOneSecondDifference() throws {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        
        let records: [WaterRecord] = [
            WaterRecord(waterAmount: 100.0, date: dateFormatter.date(from: "2022-04-16 05:59:59")!),
            WaterRecord(waterAmount: 100.0, date: dateFormatter.date(from: "2022-04-16 06:00:01")!)
        ]
        let period = userSettings.startDayInterval
        let startDate = period.from
        let endDate = period.to
        
        let result = calculator.sumOfWater(records, from: startDate, to: endDate)
        
        XCTAssertEqual(result, 100.0)
        
    }

}
