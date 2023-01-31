//
//  MainSettingsViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 27.01.2023.
//

import UIKit

class MainSettingsViewController: UIViewController {

    private let notifications = Notifications()
    private let waterModel = WaterModel()
    private let dateService = DateService()
    private let healthKit = HealthKitAdapter()
    
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBar()
    }
    
    func configureBar() {
        tabBarView.layer.cornerRadius = tabBarView.frame.size.height / 2
        tabBarView.layer.shadowColor = UIColor.black.cgColor
        tabBarView.layer.shadowOpacity = 0.5
        tabBarView.layer.shadowOffset = .zero
        tabBarView.layer.shadowRadius = 10
    }
}


extension MainSettingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayTarget", for: indexPath) as? DayTargetCollectionViewCell else { return UICollectionViewCell() }
            cell.configureView()
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "period", for: indexPath) as? PeriodCollectionViewCell else { return UICollectionViewCell() }
            cell.configureView()
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "notification", for: indexPath) as? NotificationCollectionViewCell else { return UICollectionViewCell() }
            cell.configureView()
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "healthKit", for: indexPath) as? HealthKitCollectionViewCell else { return UICollectionViewCell() }
            cell.configureView()
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reset", for: indexPath) as? ResetCollectionViewCell else { return UICollectionViewCell() }
            cell.configureView()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "setTarget", sender: self)
        case 1:
            performSegue(withIdentifier: "setPeriod", sender: self)
        case 2:
            print("Switch works")
        case 3:
            print("Upload Data to HealthKit")
        case 4:
            resetAlert()
        default:
            print("DidSelectRow error")
        }
    }
}


extension MainSettingsViewController {
    
    private func resetAlert() {
        let alertController = UIAlertController(title: "Reset",
                                                message: "Do you want to reset settings",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "Reset", style: .default) { (_) in
            self.resetSettings()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func resetSettings() {
        //let newSettings = UserSettings(dayTarget: 0, startDayInterval: 21599, weight: 0)
        //waterModel.editSettings(newSettings: newSettings)
        //configureUI()
    }
}
