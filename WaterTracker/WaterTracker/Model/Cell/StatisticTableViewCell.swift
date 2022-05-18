//
//  StatisticTableViewCell.swift
//  WaterTracker
//
//  Created by Андрей  on 18.04.2022.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {
    
    let userSettings = UserSettings()

    @IBOutlet weak var waterAmountLable: UILabel!
    
    @IBOutlet weak var dateLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(record: WaterRecord) {
        let convertedDate = UserSettings.convertDate(record.date)
        
        waterAmountLable.text = "Added amount: \(record.waterAmount)"
        dateLable.text = "Date: \(convertedDate)"
    }

    

}
