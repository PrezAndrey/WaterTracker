//
//  Notifications.swift
//  WaterTracker
//
//  Created by Андрей  on 19.07.2022.
//

import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    private func requestNotification() {
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            
            self.getNotificationSettings()
        }
    }
    
    
    private func getNotificationSettings() {
    
        notificationCenter.getNotificationSettings { (settings) in
            
            print("Notification settings: \(settings)")
        }
    }
    
    
    func checkAuthorization() {
        
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                self.requestNotification()
            }
        }
    }
}
