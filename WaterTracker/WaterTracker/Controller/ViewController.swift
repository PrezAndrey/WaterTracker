//
//  ViewController.swift
//  WaterTracker
//
//  Created by Андрей През on 20.12.2021.
//
// ViewController - отвечает за то, как данные отображать, знает откуда получить и куда передать данные о выпитой воде

import UIKit

class ViewController: UIViewController {
    
    private var waterModel: WaterModelProtocol = WaterModel()
    
    
    
    // MARK: Outlets
    
    
    
    @IBOutlet weak var waterLable: UILabel! {
        didSet {
            updateWaterAmount()
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        updateWaterAmount()
    }
    
    override func viewDidLoad() {
        waterModel.delegate = self
        self.configureUI()
    }
    
    func configureUI() {
        updateWaterAmount()
    }

    // MARK: Functions
   
   
    // Add 100 ml button
    @IBAction func didAdd100(_ sender: UIButton) {
        addMl(100.0)

    }
    
    // Add 250ml button
    @IBAction func didAdd250(_ sender: UIButton) {
        addMl(250.0)

    }
    
    
    // Correct button
    @IBAction func didCorrect(_ sender: UIButton) {
        
        // Alert
        let alertController = UIAlertController(title: "Corrections", message: "You can correct the amount of water", preferredStyle: .alert)
        let action = UIAlertAction(title: "Set", style: .default) { (action) in
            if let waterMl = Double(alertController.textFields?.first?.text ?? "0.0") {
                print(waterMl)
                self.addMl(waterMl)

            }
            else {
                print("Error")
            }
        }
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func didDelete(_ sender: Any) {
        waterModel.deleteChosen(nil, last: true)
    }
    
    // Add ml function
    private func addMl(_ number: Double) {
        
        waterModel.addWater(number)
    }
    
    // Update water amount
    private func updateWaterAmount() {
        waterLable.text = "Сегодня я выпил: \(waterModel.waterAmount) мл"
    }
    
    
}

extension ViewController: WaterModelDelegate {
    func waterAmountDidUpdate(_ model: WaterModelProtocol) {
        waterLable.text = "Сегодня я выпил: \(waterModel.waterAmount) мл"
    }
    
    
}


