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
        
        layer.borderWidth = 1
        layer.borderColor = Canvas.super_light_gray.cgColor
        
        roundCorners()
        // don't round these corners
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        layer.backgroundColor = Canvas.electric_blue.withAlphaComponent(0.6).cgColor
    }
}
