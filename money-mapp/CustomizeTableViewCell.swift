//
//  CustomizeTableViewCell.swift
//  money-mapp
//
//  Created by Alice Wu on 8/10/18.
//  Copyright © 2018 Alice Wu. All rights reserved.

import UIKit

class CustomizeTableViewCell: UITableViewCell {

    static let reuse_id = "CustomizeTableViewCell"
    
    @IBOutlet weak var action_name: UILabel!
    @IBOutlet weak var action_image: UIImageView!
    
    var parent : CustomizeVC!
    
    func initialize(_ index: Int) {
        action_name.text = parent.options[index].name
        action_image.image = parent.options[index].image
        
        roundCorners(9)
        // don't round these corners
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        layer.backgroundColor = Canvas.brewed_mustard.withAlphaComponent(0.8).cgColor
    }
}
