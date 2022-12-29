//
//  SetTargetViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 27.12.2022.
//

import UIKit

class SetTargetViewController: UIViewController {
    
    

    @IBOutlet weak var dayTargetButton: UIButton!
    @IBOutlet weak var periodButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func configure(button: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            button.setTitle("Complete!", for: .normal)
            button.layer.backgroundColor = UIColor.systemGreen.cgColor
            self.isCompeted()
            print("Button text \(button.titleLabel?.text)")
            print("Button color \(button.backgroundColor?.description)")
        }
    }
    
    func isCompeted() {
        if dayTargetButton.backgroundColor == periodButton.backgroundColor {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func skip(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func setDayTarget(_ sender: Any) {
        performSegue(withIdentifier: "setTarget", sender: nil)
        configure(button: dayTargetButton)
    }
    
    @IBAction func setStartTime(_ sender: Any) {
        performSegue(withIdentifier: "setTime", sender: nil)
        configure(button: periodButton)
        
    }
    // Fix unwind segue. Not working cause of XCODE 14.1 bug
    @IBAction func unwindSegue(_  sender: UIStoryboardSegue) {
        print("Unwinding ...")
    }
}
