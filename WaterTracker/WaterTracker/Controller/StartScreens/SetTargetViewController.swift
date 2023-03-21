//
//  SetTargetViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 27.12.2022.
//

import UIKit

class SetTargetViewController: UIViewController {
    
    let dayTargetButton = UIButton()
    let periodButton = UIButton()
    let startButton = UIButton()
    let textLabel = UILabel()
    let greetingImage = UIImageView()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = LinearGradientView()
        setButtons()
        setTextLabel()
        setImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureButton(button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .universalBlue
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: "SFProDisplayRegular.otf", size: 25)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        
        switch button {
        case dayTargetButton:
            button.addTarget(self, action: #selector(didSetTarget), for: .touchUpInside)
            button.frame = CGRect(x: 40, y: 700, width: 150, height: 80)
            button.setTitle("Set target", for: .normal)
            button.titleLabel?.font = UIFont(name: "SFProDisplayRegular.otf", size: 25)
        case periodButton:
            button.addTarget(self, action: #selector(didSetPeriod), for: .touchUpInside)
            button.frame = CGRect(x: 210, y: 700, width: 150, height: 80)
            button.setTitle("Set period", for: .normal)
            button.titleLabel?.font = UIFont(name: "SFProDisplayRegular.otf", size: 25)
        case startButton:
            button.addTarget(self, action: #selector(didStart), for: .touchUpInside)
            button.frame = CGRect(x: 40, y: 700, width: 300, height: 80)
            button.setTitle("Start", for: .normal)
            button.isHidden = true
            button.titleLabel?.font = UIFont(name: "SFProDisplayRegular.otf", size: 25)
        default:
            print("Error...")
        }
        view.addSubview(button)
    }
    
    func setTextLabel() {
       textLabel.frame = CGRect(x: 40, y: 350, width: 300, height: 250)
       textLabel.text = "The final step is to set a time tracking period and daily target, which can be done manually or using the target generator. Additionally, make sure to input your weight"
       textLabel.numberOfLines = 0
       textLabel.font = UIFont(name: "SFProDisplayRegular.otf", size: 25)
       textLabel.textColor = .white
       textLabel.textAlignment = .center
       textLabel.font = .boldSystemFont(ofSize: 25)
        view.addSubview(textLabel)
    }
    
    func setButtons() {
        let buttons = [dayTargetButton, periodButton, startButton]
        for button in buttons {
            configureButton(button: button)
        }
    }
    
    func setImage() {
        greetingImage.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        greetingImage.image = UIImage(named: "data")
        greetingImage.contentMode = .scaleAspectFit
        view.addSubview(greetingImage)
    }
    
    @objc func didSetTarget() {
        performSegue(withIdentifier: String(describing: AutoAimViewController.self), sender: nil)
        configure(button: dayTargetButton)
    }
    
    @objc func didSetPeriod() {
        performSegue(withIdentifier: String(describing: StartingTimeViewController.self), sender: nil)
        configure(button: periodButton)
    }
    
    @objc func didStart() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func configure(button: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            button.setTitle("Complete!", for: .normal)
            button.layer.backgroundColor = UIColor.universalGreen.cgColor
            self.isCompeted()
        }
    }
    
    func isCompeted() {
        if dayTargetButton.backgroundColor == periodButton.backgroundColor {
            dayTargetButton.isHidden = true
            periodButton.isHidden = true
            startButton.isHidden = false
            startButton.backgroundColor = .universalGreen
        }
    }
//
//    @IBAction func skip(_ sender: Any) {
//        navigationController?.popToRootViewController(animated: true)
//    }
//
//    @IBAction func setDayTarget(_ sender: Any) {
//        performSegue(withIdentifier: "setTarget", sender: nil)
//        configure(button: dayTargetButton)
//    }
//
//    @IBAction func setStartTime(_ sender: Any) {
//        performSegue(withIdentifier: "setTime", sender: nil)
//        configure(button: periodButton)
//    }
}
