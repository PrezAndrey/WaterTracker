//
//  Main2ViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 20.01.2023.
//

import UIKit

class Main2ViewController: UIViewController {
    
    @IBOutlet weak var viewForTabBar: UIView!
    
    @IBOutlet weak var addWaterView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    func configureTabBar() {
        viewForTabBar.layer.cornerRadius = viewForTabBar.frame.size.height / 2
        addWaterView.layer.cornerRadius = 30
        
    }

    
    @IBAction func addWater100(_ sender: Any) {
        print("__________ 100 ml of water is added _________")
    }
    
    @IBAction func addWater250(_ sender: Any) {
        print("__________ 250 ml of water is added _________")
    }
    
    @IBAction func deleteAmount(_ sender: Any) {
        print("__________ last water amount deleted _________")
    }
    @IBAction func addCustomAmount(_ sender: Any) {
        print("__________ add custom water amount _________")
    }
}
