//
//  NotificationViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 27.12.2022.
//

import UIKit

class NotificationViewController: GreetingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
//    @IBAction func askForAuthorization(_ sender: Any) {
//        _ = notifications.checkAuthorization()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.performSegue(withIdentifier: "segueToPeriod", sender: self)
//        }
//    }
    
    private func updateView() {
        greetingTextLabel.text = "Notifications will remind you to drink water and inform you when you reach your daily target"
        configButton.setTitle("Notifications", for: .normal)
        greetingImage.image = UIImage(named: "notifications")
    }
}
