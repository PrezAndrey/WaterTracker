//
//  NotificationCollectionViewCell.swift
//  WaterTracker
//
//  Created by Андрей  on 28.01.2023.
//

import UIKit

class NotificationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView!
    func configureView() {
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 2
        cellView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
    }
}
