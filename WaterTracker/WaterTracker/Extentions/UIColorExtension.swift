//
//  UIColorExtension.swift
//  WaterTracker
//
//  Created by Андрей  on 16.03.2023.
//

import UIKit

extension UIColor {
    
    static let universalBlue = UIColor().colorFromHex("536DED")
    static let universalBlack = UIColor().colorFromHex("18171C")
    static let universalGray = UIColor().colorFromHex("2F2F37")
    static let universalYellow = UIColor().colorFromHex("FFC553")
    
    func colorFromHex(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
        }
        
        var rgb: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgb)
        
        return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgb & 0x0000FF) / 255.0,
                       alpha: 1.0)
    }
}
