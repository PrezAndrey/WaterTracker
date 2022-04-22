//
//  WaterCalculator.swift
//  WaterTracker
//
//  Created by Андрей  on 14.04.2022.
//

import Foundation

class WaterCalculator {
    func sumOfWater(_ waterRecordArray: [WaterRecord], from: Date, to: Date) -> Double {
        var totalWater = 0.0
        print("from: \(from)")
        print("to: \(to)")
        for record in waterRecordArray {
            if from <= record.date && record.date <= to {
                totalWater += record.waterAmount
                
            }
        }
        return totalWater
    }
    
    
    func waterAimGenerator(weight: Int) -> Double {
        let standartAim = weight * 30
        
        return Double(standartAim)
        
    }
}
