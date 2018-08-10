//
//  PurchaseTableViewCell.swift
//  money-mapp
//
//  Created by Alice Wu on 8/7/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {
    
    static let reuse_id = "PurchaseTableViewCell"

    @IBOutlet weak var price_view: UIView!
    @IBOutlet weak var price_label: UILabel!
    @IBOutlet weak var details_view: UIView!
    @IBOutlet weak var purchase_name: UILabel!
    @IBOutlet weak var purchase_date: UILabel!
    @IBOutlet weak var separator_line: UIView!
    
    var parent : ExpensesVC!
    var category_index : Int!
    var purchase : Purchase!
    
    func initialize(_ parent: ExpensesVC, _ category_index: Int, _ purchase_id: Int) {
        self.parent = parent
        self.category_index = category_index
        self.purchase = parent.categories_vc.categories[category_index].purchases[purchase_id]
        
        price_view.roundCorners(7.5)
        self.roundCorners(9)
        
        // don't round these corners
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        self.layer.backgroundColor = Canvas.peach.cgColor
        
        // change the alpha from 0.5 to 1.0
        let color = UIColor(cgColor: self.layer.backgroundColor!)
        
        if purchase_id % 2 == 0 {
            self.layer.backgroundColor = color.withAlphaComponent(0.6).cgColor
        }
        // set the cell information
        if let name = purchase.name, let date = purchase.date {
            purchase_name.text = name
            print(name)
            purchase_date.text = date
            print(date)
        }
        price_label.text = "$" + String(format: "%.2f", purchase.cost)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        print("implement")
    }
    
}
