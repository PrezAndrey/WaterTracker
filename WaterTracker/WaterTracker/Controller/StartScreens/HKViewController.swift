//
//  HKViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 27.12.2022.
//

import UIKit

class HKViewController: GreetingViewController {
    
//    let healthKitService = HealthKitAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        updateView()
    }
    
    private func updateView() {
        greetingTextLabel.text = "All your water records will be syncronized with HelathKit, it will make it esier to handle your statistic"
        configButton.setTitle("HealthKit", for: .normal)
        laterButton.titleLabel?.text = "Skip"
    }
}
