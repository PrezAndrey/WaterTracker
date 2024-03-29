//
//  LinearGradientView.swift
//  WaterTracker
//
//  Created by Андрей  on 16.02.2023.
//

import UIKit


class LinearGradientView: UIView {
    
    let topColor = UIColor.universalBlue
    let bottomColor = UIColor.white
    let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        layer.addSublayer(gradientLayer)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if gradientLayer.frame != bounds {
            gradientLayer.frame = bounds
        }
        
        let newColors = [UIColor.white.cgColor, UIColor.universalBlue.cgColor]
        
        gradientLayer.setColors(newColors, animated: true, withDuration: 5, timingFunctionName: .linear)
    }
}

extension CAGradientLayer {
    
    func setColors(_ newColors: [CGColor], animated: Bool = true, withDuration duration: TimeInterval = 0, timingFunctionName name: CAMediaTimingFunctionName? = nil) {
        
        if !animated {
            colors = newColors
            return
        }
        
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.fromValue = colors
        colorAnimation.toValue = newColors
        colorAnimation.duration = duration
        colorAnimation.isRemovedOnCompletion = false
        colorAnimation.fillMode = CAMediaTimingFillMode.forwards
        colorAnimation.timingFunction = CAMediaTimingFunction(name: name ?? .linear)
        
        add(colorAnimation, forKey: "colorChangeAnimation")
    }
}
