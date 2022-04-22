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
            configureUI()
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
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
        waterModel.deleteLast()
        configureUI()
        
    }
    
    // Add ml function
    private func addMl(_ number: Double) {
        
        waterModel.addWater(number)
        checkTheTarget()
        
    }
    
    // Update water amount
    private func updateWaterAmount() {
        waterLable.text = "Сегодня я выпил: \(waterModel.waterAmount) мл"
    }
    
    private func showTargetGetAlert() {
        let alertController = UIAlertController(title: "Complete✅", message: "You've got your day target", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Continue", style: .default) { (action) in
            return
        }
        
        self.present(alertController, animated: true, completion: nil)
        alertController.addAction(alertAction)
    }
    
    private func checkTheTarget() {
        let curentTarget = waterModel.getUserSettings()
        if waterModel.waterAmount >= Double(curentTarget?.dayTarget ?? 0) {
            showTargetGetAlert()
        }
    }
    
    
}

extension ViewController: WaterModelDelegate {
    func waterAmountDidUpdate(_ model: WaterModelProtocol) {
        waterLable.text = "Сегодня я выпил: \(waterModel.waterAmount) мл"
    }
    
    
}


