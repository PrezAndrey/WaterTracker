//
//  StartingTimeViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.04.2022.
//

import Foundation
import UIKit


class StartingTimeViewController: UIViewController {
    
    
    var completion: ((Date) -> ())?
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func didSetTime(_ sender: Any) {
        let startingTime = datePicker.date
        completion?(startingTime)
        
        dismiss(animated: true)
    }
}
