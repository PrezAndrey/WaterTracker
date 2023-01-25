//
//  StatisticViewController.swift
//  WaterTracker
//
//  Created by Андрей  on 25.01.2023.
//

import UIKit

class StatisticViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

extension StatisticViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stats") as? StatsTableViewCell
        cell!.cellView.layer.cornerRadius = 20
        
        return cell!
    }
    
    
    
}
