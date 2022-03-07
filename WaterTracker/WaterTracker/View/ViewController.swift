//
//  ViewController.swift
//  WaterTracker
//
//  Created by Андрей През on 20.12.2021.
//
// ViewController - отвечает за то, как данные отображать, знает откуда получить и куда передать данные о выпитой воде

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var authButton: UIButton!
    
    @IBOutlet weak var waterLable: UILabel! {
        didSet {
            updateWaterAmount()
        }
    }
    
    private let healthKitAdapter = HealthKitAdapter.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Checking authorization status
//        HealthKitSetup.checkAuthorization()
        waterStore.initialize()
        waterStore.delegate = self
//        healthKitAdapter.authorizeIfNeeded()
       
        
    }

    // MARK: Functions
   
   
    // Add 100 ml button
    @IBAction func didAdd100(_ sender: UIButton) {
        waterStore.writeWater(amount: 100.0)
//        addMl(100)
//        healthKitAdapter.writeWater(amount: Double(100))
    }
    
    // Add 250ml button
    @IBAction func didAdd250(_ sender: UIButton) {
        waterStore.writeWater(amount: 250.0)
//        addMl(250)
//        healthKitAdapter.writeWater(amount: Double(250))
    }
    
    
    // Correct button
    @IBAction func didCorrect(_ sender: UIButton) {
        
        // Alert
        let alertController = UIAlertController(title: "Corrections", message: "You can correct the amount of water", preferredStyle: .alert)
        let action = UIAlertAction(title: "Set", style: .default) { (action) in
            if let text = Double(alertController.textFields?.first?.text ?? "0.0") {
                print(text)
                waterStore.writeWater(amount: text)
//                WaterModel.amountOfWater = text
//                self.updateWaterAmount()
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
    
    private func updateWaterAmount(_ amount: Double) {
        waterLable.text = "Сегодня я выпил: \(amount) мл"
    }
    
}

extension ViewController: WaterStoreDelegate {
    
    public func amountOfWaterDidUpdate(_ store: WaterStore, amount: Double) {
        updateWaterAmount(amount)
    }
    
}
