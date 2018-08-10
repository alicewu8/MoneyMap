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
// TODO: might have too much data
struct Category {
    var name : String
    var image : UIImage
    let id : Int
    var selected = false
    var budget : Double?
    var running_total : Double = 0
    var purchases : [Purchase] = []
}

// Represents a purchased item
// TODO: check that at least price has been entered. If not, have a reminder screen pop up
struct Purchase {
    var name : String?
    var cost : Double
    var date : String?
    // multi-line string """ """
    var info : String?
    var id : Int!
}

// TODO: implement custom UI color palettes
struct Spring {
    
}

struct Summer {
    
}

struct Fall {
    
}

struct Michigan {
    
}

// UI Colors: mostly from flatuicolors.com
struct Canvas {
    // Reds
    static let strawberry = UIColor(red: 223, green: 48, blue: 0)
    static let watermelon_red = UIColor(red: 228, green: 88, blue: 88)
    static let grapefruit = UIColor(red: 255, green: 127, blue: 80)
    static let blush = UIColor(red: 255, green: 99, blue: 72)
    static let prestige_blue = UIColor(red: 255, green: 99, blue: 72)
    static let lipstick = UIColor(red: 229, green: 80, blue: 57)
    static let artificial_watermelon = UIColor(red: 255, green: 107, blue: 129)
    
    // Yellows
    static let golden_sand = UIColor(red: 236, green: 204, blue: 104)
    static let summertime = UIColor(red: 245, green: 205, blue: 121)
    
    // Oranges
    static let peach = UIColor(red: 250, green: 152, blue: 58)
    static let melon_melody = UIColor(red: 250, green: 152, blue: 58)
    static let creamy_peach = UIColor(red: 243, green: 166, blue: 131)
    static let brewed_mustard = UIColor(red: 231, green: 127, blue: 103)
    static let sawtooth_awk = UIColor(red: 241, green: 144, blue: 102)
    static let carrot = UIColor(red: 230, green: 126, blue: 34)

    // Greens
    static let jellybean_green = UIColor(red: 46, green: 213, blue: 115)
    static let cheerful_green = UIColor(red: 123, green: 237, blue: 159)
    static let aurora_green = UIColor(red: 120, green: 224, blue: 143)
    static let emerald = UIColor(red: 46, green: 204, blue: 113)
    static let mint_leaf = UIColor(red: 0, green: 184, blue: 148)

    // Blues
    static let sky_blue = UIColor(red: 150, green: 225, blue: 255)
    static let french_sky_blue = UIColor(red: 112, green: 161, blue: 255)
    static let not_tiffany_blue = UIColor(red: 30, green: 144, blue: 255)

    // Purples
    static let purple_mountain_majesty = UIColor(red: 120, green: 111, blue:166)
    static let shy_moment = UIColor(red: 162, green: 155, blue: 254)
    
    // Pinks
    static let first_date = UIColor(red: 250, green: 177, blue: 160)

    // Neutrals
    static let marshmallow = UIColor(red: 255, green: 255, blue: 255)
    static let super_light_gray = UIColor(red: 223, green: 228, blue: 234)
}

// MARK: UIColor extension
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
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

//MARK : Custom Segue
public class SegueFromLeft: UIStoryboardSegue
{
    override public func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 20)
        
        UIView.animate(withDuration: 0.45,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 20)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}

public class SegueFromRight: UIStoryboardSegue {
    override public func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 20)
        
        UIView.animate(withDuration: 0.45,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 20)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}
