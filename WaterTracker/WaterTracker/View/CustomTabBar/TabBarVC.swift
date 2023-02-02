//
//  CustomTabBar.swift
//  WaterTracker
//
//  Created by Андрей  on 31.01.2023.
//

import UIKit

class TabBarVC: UITabBar {
    
    private var shapeLayer: CALayer?
    
    func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        }
        else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    override func draw(_ rect: CGRect) {
        print("Draw Works")
        self.addShape()
        self.unselectedItemTintColor = UIColor.lightGray
        self.tintColor = UIColor.lightGray
    }
    
    func createPath1() -> CGPath {
        print("CreatePath Works")
        let height: CGFloat = 15
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: self.frame.width, y: -20))
        path.addLine(to: CGPoint(x: centerWidth, y: 0 ))
        path.addQuadCurve(to: CGPoint(x: centerWidth - 30, y: 20), controlPoint: CGPoint(x: centerWidth - 30, y: 5))
        path.addLine(to: CGPoint(x: centerWidth - 29, y: height - 10))
        path.addQuadCurve(to: CGPoint(x: centerWidth, y: height + 10), controlPoint: CGPoint(x: centerWidth - 30, y: height + 10))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
    
    func createPath() -> CGPath {
        
        let height: CGFloat = 15
        let path = UIBezierPath( )
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint (x: 0, y: -20))
        path.addLine(to: CGPoint (x: centerWidth - 50, y: 0))
        path.addQuadCurve(to: CGPoint(x: centerWidth - 30, y: 20), controlPoint: CGPoint (x: centerWidth - 30, y: 5))
        path.addLine(to: CGPoint(x: centerWidth - 29, y: height - 10))
        path.addQuadCurve(to: CGPoint(x: centerWidth, y: height + 10), controlPoint: CGPoint(x: centerWidth - 30, y: height + 10))
        path.addQuadCurve(to: CGPoint(x: centerWidth + 40, y: height - 10), controlPoint: CGPoint(x: centerWidth + 40, y: height + 10))
        path.addLine(to: CGPoint(x: centerWidth + 41, y: 20))
        path.addQuadCurve(to: CGPoint(x: centerWidth + 50, y: 0) , controlPoint: CGPoint(x: centerWidth + 41, y: 5))
        path.addLine(to: CGPoint(x: self.frame.width, y: -20))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame .height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
}
