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
    
    private var newAmount = 0
    private var staticRecords = [WaterRecord]()
    private var dateDictionary = [String: Int]()
    private var dateArray = [String]()
    
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
        dateArray = getDictionaryForSections(staticRecords)
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
    
    private func getDictionaryForSections(_ data: [WaterRecord]) -> [String] {
//        var dateDict = [Date: Int]()
        var dateArray = data.map({ $0.date }).sorted()
        var tempArray = [String]()
        for date in dateArray {
            let dateStr = dateService.convertDateToStringForSection(date)
            if !tempArray.contains{ $0 == dateStr } {
                tempArray.append(dateStr)
            }
        }
        
        
//        for date in dateArray {
//            let stringDate = dateService.convertDateToStringForSection(date)
//            let isInDict = dateDict.keys.contains{ $0 == date }
//            if isInDict {
//                dateDict[date]! += 1
//            } else {
//                dateDict.updateValue(1, forKey: date)
//            }
//        }
//        dateArray = dateDict.keys.map({ $0 }).sorted()
//        print("DateArray is \(dateArray)")
//        print("DateDict is \(dateDict)")
//        let resultArray = dateArray.map({ dateService.convertDateToStringForSection($0) })
//        print(resultArray)
        return tempArray
        
        
        
//        var dateArray = [Date]()
//        var dateDict = [String: Int]()
//
//        for record in data {
////            let stringDate = dateService.convertDateToStringForSection(record.date)
////            dateArray.append(stringDate)
//            dateArray.append(record.date)
//        }
//        dateArray = dateArray.sorted()
//        print("Array of dates: \(dateArray)")
//
//
//
//        for date in dateArray {
//            let date = dateService.convertDateToStringForSection(date)
//
//            let isInDict = dateDict.keys.contains{ $0 == date }
//            if isInDict {
//                dateDict[date]! += 1
//            } else {
//                dateDict.updateValue(1, forKey: date)
//            }
//        }
//
//        return dateDict
    }
}


// MARK: TableView Delegate
extension StatsViewController: UITableViewDelegate {
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
            let recordToDelete = staticRecords.remove(at: indexPath.row)
            waterModel.deleteRecord(record: recordToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}



// MARK: TableView DataSource
extension StatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return staticRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StatisticTableViewCell.self), for: indexPath) as? StatisticTableViewCell {
            let info = staticRecords[indexPath.row]
            cell.configureWith(record: info)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var keyName = [String]()
//        for date in dateDictionary.keys {
//            keyName.append(date)
//        }
//        print("Number of elements in string \(keyName[2].count)")
//        return keyName[section]
        return dateArray[section]
    }
}

