//
//  Analyze.swift
//  money-mapp
//
//  Created by Alice Wu on 8/24/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit
import Charts

class Analyze: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var anaylzeLabel: UILabel!
    @IBOutlet weak var spendingChart: PieChartView!
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var totalSpentLabel: UILabel!
    @IBOutlet weak var averageExpenseLabel: UILabel!
    
    var clothesDataEntry = PieChartDataEntry(value: 0)
    var groceriesDataEntry = PieChartDataEntry(value: 0)
    
    var spendingByCategory = [PieChartDataEntry]()
    
    var categories_vc : CategoriesVC!
    
    // stores the ids of the used categories in order
    var indicesOfCategories = [Int]()
    
    var total_spent : Double = 0
    var average_spent : Double = 0
    
    // used to calculate average spending amount
    var categories_used : Int = 0
    
    func initialize(_ parent: CategoriesVC) {
        self.categories_vc = parent
        
        // initailize the table view
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.register(UINib(nibName: "StatsTableViewCell", bundle: nil), forCellReuseIdentifier: StatsTableViewCell.reuse_id)
        
        spendingChart.chartDescription?.text = ""
        
        // TODO: hard coding for now, modify later
        anaylzeLabel.text = "August Expenses"
        
        calculateBasicStats()
        
        calculateChartData()
        
        updateChartData()
        
        updateLabels()
        
        //dataTable.reloadData()
    }
    
    func calculateBasicStats() {
        for i in 0..<categories_vc.categories.count {
            if categories_vc.categories[i].in_use {
                total_spent += categories_vc.categories[i].running_total
                
                categories_used += 1
                indicesOfCategories.append(i)
            }
        }
        print(total_spent)
        
        average_spent = total_spent / Double(categories_used)
    }
    
    func updateLabels() {
        totalSpentLabel.text = "Total Spent: $" + String(format: "%.2f", total_spent)
        averageExpenseLabel.text = "Avg Expense: $" + String(format: "%.2f", average_spent)
    }
    
    func calculateChartData() {
        for i in 0..<categories_vc.categories.count {
            // if this purchases have been made in this category, add it to the graph
            if categories_vc.categories[i].in_use {
                // the value in chart represents the percent of money spent in this category
                let newDataEntry = PieChartDataEntry(value: (categories_vc.categories[i].running_total / total_spent) * 100)
                
                newDataEntry.label = categories_vc.categories[i].name
                newDataEntry.data = categories_vc.categories[i].budget as AnyObject
                
//                var resizedImage = ResizeImage(categories_vc.categories[i].image, targetSize: CGSize(width: 40, height: 40))
//                newDataEntry.icon = resizedImage
                
                spendingByCategory.append(newDataEntry)
            }
        }
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(values: spendingByCategory, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [Canvas.bright_lilac, Canvas.creamy_peach, Canvas.artificial_watermelon, Canvas.blush]
        let font = UIFont(name: "AvenirNext-Medium", size: 15)
        let numberFont = UIFont(name: "AvenirNext-DemiBold", size: 17)
        
        // cast to the correct data type
        chartDataSet.colors = colors
        chartDataSet.entryLabelFont = font
        chartDataSet.valueFont = numberFont!
        chartDataSet.valueLinePart1OffsetPercentage = 10
        chartDataSet.automaticallyDisableSliceSpacing = true
        chartDataSet.selectionShift = 10
        
        // append percentage sign
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        chartDataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
        
        spendingChart.data = chartData
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories_used
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        let cell = dataTable.dequeueReusableCell(withIdentifier: StatsTableViewCell.reuse_id, for: indexPath) as! StatsTableViewCell
        cell.initialize(self, categories_vc, index)
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
