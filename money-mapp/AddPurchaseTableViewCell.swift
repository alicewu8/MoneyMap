//
//  AddPurchaseTableViewCell.swift
//  money-mapp
//
//  Created by Alice Wu on 8/7/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class AddPurchaseTableViewCell: UITableViewCell {
    
    static let reuse_id = "AddPurchaseTableViewCell"
    
    var parent : ExpensesVC!

    func initialize(_ parent: ExpensesVC) {
        self.roundCorners(9)
        
        // don't round these corners
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        self.parent = parent
        layer.backgroundColor = Canvas.grapefruit.cgColor
    }
    
}
