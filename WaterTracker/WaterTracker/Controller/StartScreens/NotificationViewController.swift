//
//  NotificationViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 27.12.2022.
//

import UIKit

class NotificationViewController: UIViewController {
    
    let notifications = Notifications()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func askForAuthorization(_ sender: Any) {
        notifications.checkAuthorization()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.performSegue(withIdentifier: "segueToPeriod", sender: self)
        }
    }
    
}
