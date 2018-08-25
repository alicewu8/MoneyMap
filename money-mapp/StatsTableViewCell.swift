//
//  StatsTableViewCell.swift
//  money-mapp
//
//  Created by Alice Wu on 8/25/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

// TODO: dynamic cell sizing!
class StatsTableViewCell: UITableViewCell {

    static let reuse_id = "StatsCell"
    
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var numPurchasesLabel: UILabel!
    @IBOutlet weak var budgetStatusLabel: UILabel!
    @IBOutlet weak var totalSpentView: UIView!
    @IBOutlet weak var totalSpentLabel: UILabel!
    @IBOutlet weak var photoFrame: UIView!
    
    var parent : Analyze!
    var categories_vc : CategoriesVC!
    
    func initialize(_ parent: Analyze, _ categoriesVC: CategoriesVC, _ index: Int) {
        self.parent = parent
        self.categories_vc = categoriesVC
        
        self.roundCorners(7.5)
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        totalSpentView.layer.backgroundColor = Canvas.marshmallow.cgColor
        totalSpentView.roundCorners(9)
        
        // store the category into a temporary variable
        let data = self.categories_vc.categories[parent.indicesOfCategories[index]]
        
        categoryIcon.image = data.image
        categoryNameLabel.text = data.name
        numPurchasesLabel.text = String(data.purchases.count) + " purchases"
        
        // check if singular
        if data.purchases.count == 1 {
            numPurchasesLabel.text = String(data.purchases.count) + " purchase"
        }
        
        totalSpentLabel.text = "$" + String(format: "%.2f", data.running_total)
        
        if let budget = data.budget {
            let remaining = budget - data.running_total
            budgetStatusLabel.text = "$" + String(format: "%.2f", remaining) + " of budget remaining"
        } else {
            budgetStatusLabel.text = "No budget was assigned"
        }
        
        self.layer.backgroundColor = Canvas.blush.cgColor
        
        // change the alpha from 0.5 to 1.0
        let color = UIColor(cgColor: self.layer.backgroundColor!)
        
        if index % 2 == 0 {
            self.layer.backgroundColor = color.withAlphaComponent(0.6).cgColor
        }
    }
}
