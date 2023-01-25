//
//  Main2ViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.01.2023.
//

import UIKit


extension MainViewController {
    func configureUI() {
        configureTabBar()
        configureAddWaterView()
        configureWaterAmountView()
    }
    
    func configureTabBar() {
        tabBarView.layer.cornerRadius = tabBarView.frame.size.height / 2
        tabBarView.layer.shadowColor = UIColor.black.cgColor
        tabBarView.layer.shadowOpacity = 0.5
        tabBarView.layer.shadowOffset = .zero
        tabBarView.layer.shadowRadius = 10
    }
    
    func configureAddWaterView() {
        addWaterView.layer.cornerRadius = 30
        addWaterView.layer.shadowColor = UIColor(named: "Cyan")?.cgColor
        addWaterView.layer.shadowOpacity = 0.5
        addWaterView.layer.shadowOffset = .zero
        addWaterView.layer.shadowRadius = 10
    }
    
    func configureWaterAmountView() {
        waterAmountView.layer.cornerRadius = 20
        waterAmountView.layer.shadowColor = UIColor(named: "Cyan")?.cgColor
        waterAmountView.layer.shadowOpacity = 0.5
        waterAmountView.layer.shadowOffset = .zero
        waterAmountView.layer.shadowRadius = 10
    }
}
