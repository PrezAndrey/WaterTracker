//
//  HKViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 27.12.2022.
//

import UIKit

class HKViewController: UIViewController {
    
    let healthKitService = HealthKitAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func implementHealthKit(_ sender: Any) {
        healthKitService.authorizeIfNeeded()
        performSegue(withIdentifier: "notifications", sender: self)
    }
}
