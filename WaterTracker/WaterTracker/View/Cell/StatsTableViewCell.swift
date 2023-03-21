//
//  StatsTableViewCell.swift
//  WaterTracker
//
//  Created by Андрей  on 25.01.2023.
//

import UIKit


class StatsTableViewCell: UITableViewCell {
    
    let dateService = DateService()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var waterAmountLable: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    func configureWith(record: WaterRecord) {
        let convertedDate = dateService.convertDateToString(record.date)
        waterAmountLable.text = "\(record.waterAmount) ml"
        dateLabel.text = "\(convertedDate)"
        cellView.layer.cornerRadius = 20
    }
}
