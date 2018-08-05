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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initialize(category: Category, parent: ExpensesVC) {
        self.parent = parent
        self.category = category
        
        price_view.roundCorners(7.5)
        
        // TODO: the
        
    }

}
