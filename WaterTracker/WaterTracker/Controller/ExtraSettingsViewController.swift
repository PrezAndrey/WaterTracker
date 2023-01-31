//
//  ExtraSettingsViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 28.01.2023.
//

import UIKit

class ExtraSettingsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ExtraSettingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weight", for: indexPath) as? WeightCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "target", for: indexPath) as? TargetCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hkData", for: indexPath)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "generate", for: indexPath)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "getData", for: indexPath)
            return cell
        default:
            print("Unknown cell")
        }
        return UICollectionViewCell()
    }
}
