//
//  StartingTimeViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.04.2022.
//

import Foundation
import UIKit


class StartingTimeViewController: UIViewController {
    
    var delegate: PickerDelegate?
    //var completion: ((Date) -> ())?
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = AutoAimViewController()
        
    }
    
    
    @IBAction func didSetTime(_ sender: Any) {
        
        delegate?.updateInterval(time: datePicker.date)
        dismiss(animated: true)
    }
}
