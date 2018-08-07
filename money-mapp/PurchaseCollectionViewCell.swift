//
//  PurchaseCollectionViewCell.swift
//  money-mapp
//
//  Created by Alice Wu on 8/4/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class PurchaseCollectionViewCell: UICollectionViewCell {

    static let reuse_id = "PurchaseCollectionViewCell"
    
    @IBOutlet weak var background_view: UIView!
    @IBOutlet weak var price_view: UIView!
    @IBOutlet weak var price_label: UILabel!
    @IBOutlet weak var details_view: UIView!
    @IBOutlet weak var purchase_name: UILabel!
    @IBOutlet weak var purchase_date: UILabel!
    
    var parent : ExpensesVC!
    var category : Category!
    var purchase : Purchase!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initialize(category: Category, parent: ExpensesVC, purchase_id: Int) {
        self.parent = parent
        self.category = category
        print(category)
        self.purchase = category.purchases[purchase_id]
        print(purchase)
        
        roundCorners(7.5)
        
        price_view.roundCorners(10)
        
        // set the cell information
        if let name = purchase.name, let date = purchase.date {
            purchase_name.text = name
            print(name)
            purchase_date.text = date
            print(date)
        }
        price_label.text = "$" + String(format: "%.2f", purchase.cost)
    }

}
