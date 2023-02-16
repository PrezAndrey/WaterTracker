//
//  HKViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 27.12.2022.
//

import UIKit

class HKViewController: GreetingViewController {
    
    let healthKitService = HealthKitAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        updateView()
    }
    
    private func updateView() {
        greetingTextLabel.text = "All your water records will be syncronized with HelathKit, it will make it esier to handle your statistic"
        configButton.setTitle("Implement HealthKit", for: .normal)
        laterButton.titleLabel?.text = "Skip"
        configButton.addTarget(self, action: #selector(implementHK), for: .touchUpInside)
        laterButton.addTarget(self, action: #selector(skip), for: .touchUpInside)
    }
    
    @objc func implementHK() {
        healthKitService.authorizeIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.performSegue(withIdentifier: "notifications", sender: self)
        }
    }
    
    @objc func skip() {
        performSegue(withIdentifier: String(describing: NotificationViewController.self), sender: self)
    }
}
