//
//  StatsViewController.swift
//  WaterTracker
//
//  Created by Андрей През on 22.12.2021.
//

import UIKit

class StatsViewController: UIViewController {
    
    private var waterModel = WaterModel()
    private var newAmount = 0
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // MARK: Prepare for Segue
    // TODO: создать статичный массив
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openCustomVolumeSegue" {
            if let customAmountVC = segue.destination as? CustomAmountVC {
                customAmountVC.completion = {[weak self] newAmount in
                    guard let self = self else { return }
                    let element = self.waterModel.records
                    
                    if let indexPath = self.tableView.indexPathForSelectedRow {
                        self.waterModel.editWaterAmount(element[indexPath.row], newAmount: newAmount)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}


extension StatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "openCustomVolumeSegue", sender: self)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentArray = waterModel.records
            let recordToDelete = currentArray[indexPath.row]
            waterModel.deleteChosen(recordToDelete, last: false)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


extension StatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = waterModel.records
        
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let info = waterModel.records
        cell.textLabel?.text = "Added amount: \(info[indexPath.row].waterAmount)"
        cell.detailTextLabel?.text = "Date: \(info[indexPath.row].date)"
        
        return cell
    }
}
