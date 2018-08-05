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
    @IBOutlet weak var message_view: UIView!
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
