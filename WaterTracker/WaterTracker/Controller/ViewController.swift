//
//  ViewController.swift
//  WaterTracker
//
//  Created by Андрей През on 20.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var authButton: UIButton!
    
    @IBOutlet weak var waterLable: UILabel! {
        didSet {
            
            updateWaterAmount()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authButton.addTarget(self, action: #selector(didAuth), for: .touchUpInside)
        authButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        authButton.center = self.view.center
        authButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        authButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        authButton.layer.cornerRadius = 20
        
       
        
    }

    // MARK: Functions
    
    @objc func didAuth() {
        HealthKitSetup.getAuthorization { (authorized, error) in
            guard authorized else {
                let message = "authorized failed"
                if let error = error {
                    print("\(message) reason \(error)")
                }
                return
            }
            print("HealthKit authorized successfuly")
        }
    }
   
   
    // Add 100 ml button
    @IBAction func didAdd100(_ sender: UIButton) {
        addMl(100)
        HealthKitSetup.writeWater(amount: Double(100))
    }
    
    // Add 250ml button
    @IBAction func didAdd250(_ sender: UIButton) {
        addMl(250)
        HealthKitSetup.writeWater(amount: Double(250))
    }
    
    
    // Correct button
    @IBAction func didCorrect(_ sender: UIButton) {
        
        // Alert
        let alertController = UIAlertController(title: "Corrections", message: "You can correct the amount of water", preferredStyle: .alert)
        let action = UIAlertAction(title: "Set", style: .default) { (action) in
            if let text = Int(alertController.textFields?.first?.text ?? "0") {
                print(text)
                WaterModel.amountOfWater = text
                self.updateWaterAmount()
            }
            else {
                print("Error")
            }
        }
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Add ml function
    private func addMl(_ number: Int) {
        WaterModel.amountOfWater += number
        updateWaterAmount()
        print(WaterModel.amountOfWater)
    }
    // Update water amount
    private func updateWaterAmount() {
        waterLable.text = "Сегодня я выпил: \(WaterModel.amountOfWater) мл"
    }
    
    
    
}



