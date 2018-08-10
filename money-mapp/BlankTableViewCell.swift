//
//  BlankTableViewCell.swift
//  money-mapp
//
//  Created by Alice Wu on 8/10/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class BlankTableViewCell: UITableViewCell {

    func initialize() {
        layer.backgroundColor = Canvas.marshmallow.cgColor
        
        // disable highlight when tapped
        selectionStyle = .none
    }
}
