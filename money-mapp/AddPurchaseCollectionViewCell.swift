//
//  AddPurchaseCollectionViewCell.swift
//  money-mapp
//
//  Created by Alice Wu on 8/4/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class AddPurchaseCollectionViewCell: UICollectionViewCell {
    
    static let reuse_id = "AddPurchaseCollectionViewCell"

    @IBOutlet weak var background_view: UIView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var add_purchase_btn: UIButton!
    
    var parent : ExpensesVC!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initialize(parent: ExpensesVC) {
        self.parent = parent
        
        self.roundCorners(10)
    }
    
    @IBAction func addPurchaseTapped(_ sender: Any) {
        parent.performSegue(withIdentifier: "to_add_purchase", sender: self)
    }
}
