//
//  Extensions.swift
//  money-mapp
//
//  Created by Alice Wu on 8/2/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import Foundation
import UIKit

// Represents a purchase category
struct Category {
    var name : String
    var image : UIImage
    let id : Int
    var selected = false
    var budget : Double?
    var running_total : Double
}

// Represents a purchased item
struct Purchase {
    let name : String
    let price : Double
    let date_of_purchase : String
}

// UI Colors
struct Canvas {
    static let watermelon_red = UIColor(red: 228, green: 88, blue: 88, alpha: 1)
    static let sky_blue = UIColor(red: 150, green: 225, blue: 255, alpha: 1)
}

// MARK : UIView Layout Modification
extension UIView {
    func roundCorners(_ radius: CGFloat = 8.0) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

// MARK: Collection View
extension UICollectionView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        next?.touchesBegan(touches, with: event)
    }
}
