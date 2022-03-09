//
//  WaterSettings.swift
//  WaterTracker
//
//  Created by Андрей През on 09.03.2022.
//

import Foundation

enum Sex {
    case male
    
    case female
}

struct UserSettings {

    
    var dayTarget: Double
    
    let startDayInterval: TimeInterval
    
    var dateOfBirth: Date
    
    var sex: Sex
    
    var height: Double
    
    var weight: Double
    
    
}
