//
//  HistoryTableViewCell.swift
//  money-mapp
//
//  Created by Alice Wu on 8/10/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var category_image: UIImageView!
    @IBOutlet weak var category_name: UILabel!
    @IBOutlet weak var purchase_name: UILabel!
    @IBOutlet weak var purchase_date: UILabel!
    @IBOutlet weak var price_view: UIView!
    @IBOutlet weak var price_label: UILabel!
    
    var parent : CategoriesVC!
    var index_of_item : Int!
    
    
}
