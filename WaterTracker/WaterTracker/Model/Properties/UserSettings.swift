//
//  WaterSettings.swift
//  WaterTracker
//
//  Created by Андрей През on 09.03.2022.
//

import Foundation

struct UserSettings: Codable, Equatable {

    var dayTarget: Int? = 2001
    var startDayInterval: TimeInterval? = 21599
    var weight: Int?
    var notificationState: Bool?
}
