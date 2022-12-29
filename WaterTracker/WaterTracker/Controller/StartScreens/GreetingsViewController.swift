//
//  GreetingsViewController.swift
//  WaterTracker
//
//  Created by Андрей През on 22.12.2021.
//

import UIKit

class GreetingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Greetings Navigation Controller: \(self.navigationController)")
    }
    

    @IBAction func didTapToMoveToMain() {
        navigationController?.popViewController(animated: true)
    }
}
