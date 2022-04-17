//
//  StatsViewController.swift
//  WaterTracker
//
//  Created by Андрей През on 22.12.2021.
//

import UIKit

class StatsViewController: UIViewController {
    
    private var waterModel = WaterModel()
    private var waterStore = WaterStore()
    private var newAmount = 0
    private var staticRecords = [WaterRecord]()
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadRecords()
    }
    
    private func reloadRecords() {
        staticRecords = waterStore.getRecords()
        tableView.reloadData()
    }
    
    // MARK: Prepare for Segue
    // TODO: создать статичный массив
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openCustomVolumeSegue" {
            if let customAmountVC = segue.destination as? CustomAmountVC {
                customAmountVC.completion = {[weak self] newAmount in
                    guard let self = self else { return }
                   
                    
                    if let indexPath = self.tableView.indexPathForSelectedRow {
                        self.waterModel.editWaterAmount(self.staticRecords[indexPath.row], newAmount: newAmount)
                        self.reloadRecords()
                        
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
            
            let recordToDelete = staticRecords.remove(at: indexPath.row)
            
            waterModel.deleteChosen(recordToDelete, last: false)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }
    }
}


extension StatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return staticRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let info = staticRecords
        cell.textLabel?.text = "Added amount: \(info[indexPath.row].waterAmount)"
        cell.detailTextLabel?.text = "Date: \(info[indexPath.row].date)"
        
        return cell
    }
}
