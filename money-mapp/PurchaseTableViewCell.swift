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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialize(_ parent: ExpensesVC) {
        
    }
    
}
