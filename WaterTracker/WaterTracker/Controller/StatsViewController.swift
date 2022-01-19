//
//  StatsViewController.swift
//  WaterTracker
//
//  Created by Андрей През on 22.12.2021.
//

import UIKit

class StatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Stats Navigation Controller: \(String(describing: self.navigationController))")
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func didTapToMoveToCustom() {
        self.performSegue(withIdentifier: "openCustomVolumeSegue", sender: self)
    }
    
}
