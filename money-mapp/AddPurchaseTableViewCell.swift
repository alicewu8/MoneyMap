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
        layer.backgroundColor = Canvas.emerald.cgColor
        
        // add tap gesture recognizer for add purchase action
        let tap = UITapGestureRecognizer(target: self, action: #selector(addPurchaseTapped(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc func addPurchaseTapped(_ sender: UITapGestureRecognizer) {
        
        // animate the user interaction
        let color = UIColor(cgColor: self.layer.backgroundColor!)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.backgroundColor = color.withAlphaComponent(0.5).cgColor
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.9)
            self.layoutIfNeeded()
        }) { (success: Bool) in
            self.layer.backgroundColor = color.cgColor
            self.transform = CGAffineTransform.identity
        }
        
        parent.performSegue(withIdentifier: "to_add_purchase", sender: self)
    }
    
}
