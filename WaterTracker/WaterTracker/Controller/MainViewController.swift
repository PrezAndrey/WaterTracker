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
    
    private var savedTarget: Int?
    
    private var currentWaterAmount: Double = 0 {
        didSet {
            updateWaterAmount()
        }
    }
    
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
        if checkFirstStart() {
            performSegue(withIdentifier: "greeting", sender: self)
        }
        waterModel.delegate = self
        self.configureUI()
        
    }
    

    
    // MARK: Functions
    func configureUI() {
        currentWaterAmount = waterModel.waterAmount
    }
    
    
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
        customAmountAlert()
    }
    
    
    @IBAction func didDelete(_ sender: Any) {
        waterModel.deleteLast()
        configureUI()
    }
    
    
    // Add ml function
    private func addMl(_ number: Double) {
        let notState = waterModel.addWater(number)
        print("Water amount: \(waterModel.waterAmount)")
        
    }
        
    // Update water amount
    private func updateWaterAmount() {
        waterLable.text = "Сегодня я выпил: \(waterModel.waterAmount) мл"
    }
    
    
    func checkFirstStart() -> Bool {
        let userSettings = waterModel.getUserSettings()
        if userSettings == nil {
            return true
        }
        return false
    }
}


// MARK: WaterModelDelegate

extension ViewController: WaterModelDelegate {
    func waterAmountDidUpdate(_ model: WaterModelProtocol) {
        showAlertIfNeeded(waterModel.waterAmount)
        currentWaterAmount = waterModel.waterAmount
    }
}


// MARK: Alerts

extension ViewController {
    
    // Corretion Alert
    private func customAmountAlert() {

        let alertController = UIAlertController(title: "Corrections", message: "You can correct the amount of water", preferredStyle: .alert)
        let action = UIAlertAction(title: "Set", style: .default) { (_) in
            if let waterMl = Double(alertController.textFields?.first?.text ?? "0.0") {
                print(waterMl)
                self.addMl(waterMl)
            } else {
                print("Error")
            }
        }
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Target Alert
    private func showGetTargetAlert() {
        
        let alertController = UIAlertController(title: "Complete✅", message: "You've got your day target", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Continue", style: .default) { (_) in
            return
        }
        
        self.present(alertController, animated: true, completion: nil)
        alertController.addAction(alertAction)
    }
    
    
    // For showGetTargetAlert
    private func showAlertIfNeeded(_ newWaterAmount: Double) {
        guard currentWaterAmount > 0 else { return }
        
        let curentTarget = waterModel.getUserSettings()
        
        guard let target = curentTarget?.dayTarget else { return }
        
        if newWaterAmount >= Double(target) && currentWaterAmount < Double(target) {
            showGetTargetAlert()
        }
    }
    
    
    // ALERT: Notifications denied in app
    private func deniedInAppAlert() {
        let title = "Custom amount"
        let message = "Введите количество воды в мл:"
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let moveToSettings = UIAlertAction(title: "Перейти", style: .default) { (action) in
            
            self.performSegue(withIdentifier: "showSettings", sender: self)
        }
        let snooze = UIAlertAction(title: "Отложить", style: .cancel)
        alertController.addAction(moveToSettings)
        alertController.addAction(snooze)
        self.present(alertController, animated: true)
    }
    
    // ALERT: Notifications denied in settings
    private func deniedInSettingsAlert() {
        let title = "Уведомления выключены в настройках телефона"
        let message = "Если вы хотите получать уведомления, перейдите: Настройки -> Уведомления -> WaterTracker"
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let moveToSettings = UIAlertAction(title: "Ок", style: .cancel)
        
        
        alertController.addAction(moveToSettings)
        self.present(alertController, animated: true)
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Custom amount", message: "Введите количество воды в мл:", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Set", style: .default) { [self] (_) in
            guard let value = alertController.textFields?.first?.text,
            let amount = Double(value)
            else { return }
            addMl(amount)
        }
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func checkTheTarget() {
        let curentTarget = waterModel.getUserSettings()
        guard let target = curentTarget?.dayTarget else { return }
        if waterModel.waterAmount >= Double(target) && target != savedTarget {
            showGetTargetAlert()
            self.savedTarget = target
        }
    }
}
