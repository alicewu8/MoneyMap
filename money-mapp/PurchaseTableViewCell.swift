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
    var category : Category!
    var purchase : Purchase!
    
    func initialize(_ parent: ExpensesVC) {
        price_view.roundCorners(7.5)
    }
    
}
