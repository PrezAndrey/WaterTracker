//
//  DayTargetTableViewCell.swift
//  WaterTracker
//
//  Created by Андрей  on 26.01.2023.
//

import UIKit


class DayTargetTableViewCell: UITableViewCell {
    
    @IBOutlet var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellView() {
        cellView.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).cgColor
    }
    

}
