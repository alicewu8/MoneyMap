//
//  Analyze.swift
//  money-mapp
//
//  Created by Alice Wu on 8/24/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit
import Charts

class Analyze: UIView {
    
    @IBOutlet weak var spendingChart: PieChartView!
    @IBOutlet weak var dataTable: UITableView!
    
    var clothesDataEntry = PieChartDataEntry(value: 0)
    var groceriesDataEntry = PieChartDataEntry(value: 0)
    
    var spendingByCategory = [PieChartDataEntry]()
    
    var categories_vc : CategoriesVC!
    
    func initialize(_ parent: CategoriesVC) {
        self.categories_vc = parent
        
        spendingChart.chartDescription?.text = ""
        clothesDataEntry.value = 40
        clothesDataEntry.label = "Clothes"
        spendingByCategory.append(clothesDataEntry)
        
        groceriesDataEntry.value = 90
        groceriesDataEntry.label = "Groceries"
        spendingByCategory.append(groceriesDataEntry)
        
        updateChartData()
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(values: spendingByCategory, label: "Spending by Category")
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [Canvas.bright_lilac, Canvas.creamy_peach]
        let font = UIFont(name: "AvenirNext-Medium", size: 18)
        
        // cast to the correct data type
        chartDataSet.colors = colors
        chartDataSet.entryLabelFont = font
        chartDataSet.valueFont = font!
        
        spendingChart.data = chartData
    }
}
