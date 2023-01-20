//
//  Main2ViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.01.2023.
//

import UIKit

class Main2ViewController: UIViewController {
    
    @IBOutlet weak var viewForTabBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    func configureTabBar() {
        viewForTabBar.layer.cornerRadius = viewForTabBar.frame.size.height / 2
        
    }

    
}
