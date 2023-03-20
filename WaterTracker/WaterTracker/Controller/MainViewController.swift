//
//  ViewController.swift
//  WaterTracker
//
//  Created by Андрей През on 20.12.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private var waterModel: WaterModelProtocol = WaterModel()
    
    private var savedTarget: Int?
    private var currentWaterAmount: Double = 0 {
        didSet {
            updateWaterAmount()
            updateWaterStatus()
        }
    }
    private var dayTarget: Int?
    
    @IBOutlet weak var waterStatus: UIImageView!
    @IBOutlet weak var waterAmountView: UIView!
    @IBOutlet weak var addWaterView: UIView!
    @IBOutlet weak var waterLable: UILabel! {
        didSet {
            updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        setTheTarget()
        updateWaterStatus()
    }
    
//    override func loadView() {
//        super.loadView()
//        view = LinearGradientView()
//    }
    
    override func viewDidLoad() {
        if checkFirstStart() {
            performSegue(withIdentifier: String(describing: GreetingViewController.self), sender: self)
        }
        waterModel.delegate = self
        updateUI()
        configureUI()
    }
    
    func setTheTarget() {
        let userSettings = waterModel.getUserSettings()
        guard let target = userSettings?.dayTarget else { return }
        dayTarget = target
    }
    
    func updateUI() {
        currentWaterAmount = waterModel.waterAmount
    }
    
    @IBAction func didAdd100(_ sender: UIButton) {
        addMl(100.0)
    }
    
    @IBAction func didAdd250(_ sender: UIButton) {
        addMl(250.0)
    }
    
    @IBAction func didCorrect(_ sender: UIButton) {
        customAmountAlert()
    }
    
    @IBAction func didDelete(_ sender: Any) {
        waterModel.deleteLast()
        updateUI()
    }
    
    private func addMl(_ number: Double) {
        _ = waterModel.addWater(number)
        print("Water amount: \(waterModel.waterAmount)")
    }
        
    private func updateWaterAmount() {
        waterLable.text = "\(waterModel.waterAmount) мл"
    }
    
    func checkFirstStart() -> Bool {
        let userSettings = waterModel.getUserSettings()
        if userSettings == nil {
            return true
        }
        return false
    }
    
    func updateWaterStatus() {
        guard let target = dayTarget, target > 0 else { return }
        
        let quarterTarget = target / 4
        let water = Int(currentWaterAmount)
        
        if water < quarterTarget {
            waterStatus.image = UIImage(named: "waterAmount")
        } else if water >= quarterTarget && water < quarterTarget * 2 {
            waterStatus.image = UIImage(named: "waterAmount1")
        } else if water >= quarterTarget * 2 && water < quarterTarget * 3 {
            waterStatus.image = UIImage(named: "waterAmount2")
        } else if water >= quarterTarget * 3 && water < quarterTarget * 4 {
            waterStatus.image = UIImage(named: "waterAmount3")
        } else {
            waterStatus.image = UIImage(named: "waterAmount4")
        }
        
    }
}


// MARK: WaterModelDelegate
extension MainViewController: WaterModelDelegate {
    func waterAmountDidUpdate(_ model: WaterModelProtocol) {
        showAlertIfNeeded(waterModel.waterAmount)
        currentWaterAmount = waterModel.waterAmount
    }
}


// MARK: Alert
extension MainViewController {
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
    
    // showGetTargetAlert
    private func showAlertIfNeeded(_ newWaterAmount: Double) {
        guard currentWaterAmount > 0 else { return }
        guard let target = dayTarget else { return }
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
        let moveToSettings = UIAlertAction(title: "Перейти", style: .default) { (_) in
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
    
    func configureUI() {
        addWaterView.layer.cornerRadius = 20
        waterAmountView.layer.cornerRadius = 10
        addWaterView.layer.borderWidth = 2
        waterAmountView.layer.borderWidth = 2
        addWaterView.layer.borderColor = UIColor.universalBlue.cgColor
        waterAmountView.layer.borderColor = UIColor.universalBlue.cgColor
        
    }
}
