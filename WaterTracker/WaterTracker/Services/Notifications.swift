//
//  Notifications.swift
//  WaterTracker
//
//  Created by Андрей  on 19.07.2022.
//

import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
// MARK: Properties
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    private var date = DateComponents()
    
    static var notificationSettings: UNNotificationSettings?
    
    
// MARK: Functions
    
    private func requestNotification() {
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
            print("Permission granted: \(granted)")
            print("Error: \(error)")
            
            guard granted else { return }
            
            self.getNotificationSettings()
        }
    }
    
    
    private func getNotificationSettings() {
    
        notificationCenter.getNotificationSettings { (settings) in
            Notifications.notificationSettings = settings
            print("Notification settings: \(Notifications.notificationSettings)")
        }
    }
    
    
    func checkAuthorization() {
        
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                self.requestNotification()
            }
        }
    }
    
    
    func scheduleTimeNotification(title: String, time: String?, waterAmount: Int, currentAim: Int) {
        
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.sound = UNNotificationSound.default
        content.badge = 1
        var identifier = "Middle Identifier"
        
        let needToDrink = currentAim - waterAmount
        if needToDrink == 0 {
            content.body = "Отлично! Вы достигли сегодняшней цели"
        } else if needToDrink < 0 {
            content.body = "Отлично! Вы достигли сегодняшней цели и даже перевыполнили ее на \(needToDrink * -1)мл"
        } else {
            content.body = "Осталось совсем чуть чуть! \(needToDrink)мл до цели"
        }
        
        switch time?.lowercased() {
        case "middle":
            date.hour = 15
            date.minute = 00
            identifier = "Middle Identifier"
        case "end":
            date.hour = 21
            date.minute = 00
            identifier = "End Identifier"
        default:
            date.hour = 21
            date.minute = 00
            identifier = "End Identifier"
        }
        
        let timeTrigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: timeTrigger)
        
        notificationCenter.add(request) { (error) in
            print("Error: \(String(describing: error?.localizedDescription))")
        }
    }
    
    
    func scheduleNotificationTest(notficationType: String, waterAmount: Double) {
        
        let content = UNMutableNotificationContent()
        
        
        content.title = notficationType
        content.body = "Water amount \(waterAmount)"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let identifire = "Local Notification"
        let request = UNNotificationRequest(identifier: identifire, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            
            print("Handling notification with the local notification identifire")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
            
        case "Delete":
            print("Delete")
        default:
            print("Unknow action")
        }
        
        completionHandler()
    }
    
    
}
