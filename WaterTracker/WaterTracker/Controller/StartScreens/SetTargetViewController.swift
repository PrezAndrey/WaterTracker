//
//  SetTargetViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 27.12.2022.
//

import UIKit

class SetTargetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func setDayTarget(_ sender: Any) {
        performSegue(withIdentifier: "setTarget", sender: nil)
    }
    
    @IBAction func setStartTime(_ sender: Any) {
        performSegue(withIdentifier: "setTime", sender: nil)
    }
    @IBAction func getBack(_ sender: Any) {
        
    }
}
