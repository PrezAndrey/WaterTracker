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
        greetingTextLabel.text = "Notifications won’t let you forget to drink some water and tell you when you get your day target"
        configButton.setTitle("Notifications", for: .normal)
    }
}
