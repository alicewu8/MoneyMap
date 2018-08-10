//
//  ColorCell.swift
//  money-mapp
//
//  Created by Alice Wu on 8/10/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import Foundation
import UIKit

class ColorCell : UICollectionViewCell {
    
    var parent : CustomizeVC!
    var index_path : IndexPath!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    func initialize(_ index : Int) {
        // make circular
        roundCorners(self.frame.width / 2)
        
        self.layer.backgroundColor = parent.colors[index]
    }
    
    // adds a tap gesture recognizer to this instance to forwards touch to CategoriesVC
    func addTap() {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(sendParent))
        self.addGestureRecognizer(tap)
    }
    
    @objc func sendParent() {
        parent.selected_color_index = index_path.row
        //parent.collectionView(parent.colors_collection_view, didSelectItemAt: index_path)
    }
}
