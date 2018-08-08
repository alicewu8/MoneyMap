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
    @IBOutlet weak var separator_view: UIView!
    
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
        
        self.layer.backgroundColor = Canvas.artificial_watermelon.cgColor
        
        print(category)
        self.purchase = category.purchases[purchase_id]
        print(purchase)
        
        roundCorners(7.5)
        
        price_view.roundCorners(10)
        
        //separator_view.roundCorners(4.5)
        
        // set the cell information
        if let name = purchase.name, let date = purchase.date {
            purchase_name.text = name
            print(name)
            purchase_date.text = date
            print(date)
        }
        price_label.text = "$" + String(format: "%.2f", purchase.cost)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(purchaseTapped(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc func purchaseTapped(_ sender: UITapGestureRecognizer) {
        parent.performSegue(withIdentifier: "to_purchase_info", sender: self)
    }

}
