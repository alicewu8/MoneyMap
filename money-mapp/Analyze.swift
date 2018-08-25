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
        
        spendingChart.chartDescription?.text = "Amount per Category"
        
        calculateChartData()
        
        updateChartData()
    }
    
    func calculateChartData() {
        // keeps track of the running total
        var total = 0
        
        // keeps track of categories viewed
        var categories_used = 0
        
        for i in 0..<categories_vc.categories.count {
            // if this purchases have been made in this category, add it to the graph
            if categories_vc.categories[i].in_use {
                // create new object each time in the loop (will this work?)
                let newDataEntry = PieChartDataEntry(value: categories_vc.categories[i].running_total)
                
                newDataEntry.label = categories_vc.categories[i].name
                newDataEntry.data = categories_vc.categories[i].budget as AnyObject
                
//                var resizedImage = ResizeImage(categories_vc.categories[i].image, targetSize: CGSize(width: 40, height: 40))
//                newDataEntry.icon = resizedImage
                
                spendingByCategory.append(newDataEntry)
                
                categories_used += 1
            }
        }
        
        
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(values: spendingByCategory, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [Canvas.bright_lilac, Canvas.creamy_peach, Canvas.artificial_watermelon, Canvas.blush]
        let font = UIFont(name: "AvenirNext-Medium", size: 15)
        let numberFont = UIFont(name: "Avenir-Next-DemiBold", size: 15)
        
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
}
