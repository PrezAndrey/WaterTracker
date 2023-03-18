//
//  GreetingViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 14.02.2023.
//

import UIKit

class GreetingViewController: UIViewController {
    
    let healthKitService = HealthKitAdapter()
    let notifications = Notifications()
    
    let laterButton = UIButton(type: .roundedRect)
    let configButton = UIButton(type: .roundedRect)
    let greetingTextLabel = UILabel()
    let greetingImage = UIImageView()
    
    override func loadView() {
        super.loadView()
        view = LinearGradientView()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }
}
 

// MARK: Buttons and Labels

extension GreetingViewController {
    
    func setLaterButton() {
        laterButton.frame = CGRect(x: 280, y: 700, width: 80, height: 80)
        laterButton.setTitle("Later", for: .normal)
        laterButton.setTitleColor(.white, for: .normal)
        laterButton.backgroundColor = .universalGray
        laterButton.layer.cornerRadius = 40
        laterButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 25.0)
        laterButton.layer.borderWidth = 2
        laterButton.layer.borderColor = UIColor.white.cgColor
        laterButton.addTarget(self, action: #selector(quit), for: .touchUpInside)
    }
    
    func setConfigureButton() {
        configButton.frame = CGRect(x: 40, y: 700, width: 200, height: 80)
        configButton.setTitle("Configure", for: .normal)
        configButton.setTitleColor(.white, for: .normal)
        configButton.backgroundColor = .universalBlue
        configButton.layer.cornerRadius = 20
        configButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 25.0)
        configButton.layer.borderWidth = 2
        configButton.layer.borderColor = UIColor.white.cgColor
        configButton.addTarget(self, action: #selector(moveToHK), for: .touchUpInside)
    }
    
    func setTextLabel() {
        greetingTextLabel.frame = CGRect(x: 40, y: 350, width: 300, height: 200)
        greetingTextLabel.text = "For better experience you need to configure app, implement Notifications and HealthKit"
        greetingTextLabel.numberOfLines = 0
        greetingTextLabel.font = UIFont(name: "Helvetica Neue", size: 25.0)
        greetingTextLabel.textColor = .white
        greetingTextLabel.textAlignment = .center
        greetingTextLabel.font = .boldSystemFont(ofSize: 25)
    }
    
    func setImage() {
        greetingImage.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        greetingImage.image = UIImage(named: "welcome")
        greetingImage.contentMode = .scaleAspectFit
    }
    
    func addViews() {
        setConfigureButton()
        setLaterButton()
        setTextLabel()
        setImage()
       
        view.addSubview(configButton)
        view.addSubview(laterButton)
        view.addSubview(greetingTextLabel)
        view.addSubview(greetingImage)
    }
    
    @objc func moveToHK() {
        switch configButton.titleLabel?.text {
        case "Configure":
            performSegue(withIdentifier: String(describing: HKViewController.self), sender: self)
        case "HealthKit":
            healthKitService.authorizeIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.performSegue(withIdentifier: String(describing: NotificationViewController.self), sender: self)
            }
        case "Notifications":
            _ = notifications.checkAuthorization()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.performSegue(withIdentifier: String(describing: SetTargetViewController.self), sender: self)
            }
        default:
            print("Error...")
        }
        
    }
    
    @objc func quit() {
        switch configButton.titleLabel?.text {
        case "Configure":
            navigationController?.popViewController(animated: true)
        case "HealthKit":
            self.performSegue(withIdentifier: String(describing: NotificationViewController.self), sender: self)
        case "Notifications":
            _ = notifications.checkAuthorization()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.performSegue(withIdentifier: String(describing: SetTargetViewController.self), sender: self)
            }
        default:
            print("Error...")
        }
    }
}
