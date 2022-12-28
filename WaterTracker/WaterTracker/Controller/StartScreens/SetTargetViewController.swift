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
        dayTargetButton.titleLabel?.text = "работай, ебаная кнопка"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("++++++++++++++++++++++++++++++++View is displaying")
    }
    
    func configure(button: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            button.setTitle("Complete!", for: .normal)
            button.layer.backgroundColor = UIColor.systemGreen.cgColor
        }
        
    }
    
    @IBAction func setDayTarget(_ sender: Any) {
        performSegue(withIdentifier: "setTarget", sender: nil)
        configure(button: dayTargetButton)
    }
    
    @IBAction func setStartTime(_ sender: Any) {
        performSegue(withIdentifier: "setTime", sender: nil)
        configure(button: periodButton)
        
        
    }
    
    @IBAction func unwindSegue(_  sender: UIStoryboardSegue) {
        print("Unwinding ...")
    }
}
