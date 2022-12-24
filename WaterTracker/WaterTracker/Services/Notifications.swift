//
//  Notifications.swift
//  WaterTracker
//
//  Created by Андрей  on 19.07.2022.
//

import UIKit
import UserNotifications


enum NotificationState {
    case deniedInApp
    case deniedInSettings
    case auth
}

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
// MARK: Properties
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    private var date = DateComponents()
    
    
    
// MARK: Functions
    
    private func requestNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { [self] (granted, error) in
            print("Permission granted: \(granted)")
            print("Error: \(String(describing: error))")
            guard granted else { return }
        }
    }
    
    func checkAuthorization() -> NotificationState {
        var notificationStatus: NotificationState = .deniedInSettings
        notificationCenter.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized:
                notificationStatus = .auth
            case .denied:
                notificationStatus = .deniedInApp
            case .notDetermined:
                self.requestNotification()
            default:
                notificationStatus = .deniedInSettings
            }
        }
        
    
        return notificationStatus
    }
    
    
    func scheduleTimeNotification(title: String, waterAmount: Double, currentAim: Int) {
        
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.sound = UNNotificationSound.default
        content.badge = 1
        var identifier = "Reminder Notification"
        
        let needToDrink = currentAim - Int(waterAmount)
        if needToDrink == 0 {
            content.body = "Отлично! Вы достигли сегодняшней цели"
        } else if needToDrink < 0 {
            content.body = "Отлично! Вы достигли сегодняшней цели и даже перевыполнили ее на \(needToDrink * -1)мл"
        } else {
            content.body = "Осталось совсем чуть чуть! \(needToDrink)мл до цели"
        }
        
        
        
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
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
