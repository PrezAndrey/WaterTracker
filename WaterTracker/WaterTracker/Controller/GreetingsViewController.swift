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
        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapToMoveToMain() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
