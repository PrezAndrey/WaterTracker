//
//  StatsViewController.swift
//  WaterTracker
//
//  Created by Андрей През on 22.12.2021.
//

import UIKit

class StatsViewController: UIViewController {
    
    private let waterModel = WaterModel()
    private let waterStore = WaterStore()
    private let dateService = DateService()
    private let dateFormatter = DateFormatter()
    
    private var staticRecords = [WaterRecord]()
    private var dateArray = [String]()
    private var rowsInSections = [[WaterRecord]]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        reloadRecords()
    }
    
    private func reloadRecords() {
        staticRecords = waterStore.getRecords()
        dateArray = getSectionNamesArray(staticRecords)
        rowsInSections = getArrayForSections(staticRecords)
        tableView.reloadData()
    }
    
    // MARK: Prepare for Segue
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


// MARK: Preparing data for tableView
extension StatsViewController {
    private func getArrayForSections(_ data: [WaterRecord]) -> [[WaterRecord]] {
        var arrayForSections = [[WaterRecord]]()
        let sections = getSectionNamesArray(data)
        for _ in 1...sections.count {
            arrayForSections.append([WaterRecord]())
        }
        for date in data {
            let stringDate = dateService.convertDateToStringForSection(date.date)
            for index in sections.indices {
                if stringDate == sections[index] {
                    arrayForSections[index].append(date)
                }
            }
        }
        return arrayForSections
    }
    
    private func getSectionNamesArray(_ data: [WaterRecord]) -> [String] {
        let dateArray = data.map({ $0.date }).sorted()
        var tempArray = [String]()
        for date in dateArray {
            let dateStr = dateService.convertDateToStringForSection(date)
            if !tempArray.contains(where: { $0 == dateStr }) {
                tempArray.append(dateStr)
            }
        }
        return tempArray
    }
}


// MARK: TableView Delegate&DataSource
extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "openCustomVolumeSegue", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dateArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recordToDelete = rowsInSections[indexPath.section].remove(at: indexPath.row)
            waterModel.deleteRecord(record: recordToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsInSections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StatisticTableViewCell.self), for: indexPath) as? StatisticTableViewCell {
            let info = rowsInSections[indexPath.section][indexPath.row]
            cell.configureWith(record: info)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateArray[section]
    }
}
