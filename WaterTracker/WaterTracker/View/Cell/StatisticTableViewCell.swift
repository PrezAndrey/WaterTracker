//
//  StatisticTableViewCell.swift
//  WaterTracker
//
//  Created by Андрей  on 18.04.2022.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {
    
    let dateService = DateService()
    
    @IBOutlet weak var waterAmountLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    func configureWith(record: WaterRecord) {
        let convertedDate = dateService.convertDateToString(record.date)
        waterAmountLable.text = "Added amount: \(record.waterAmount)"
        dateLable.text = "Date: \(convertedDate)"
    }
}
