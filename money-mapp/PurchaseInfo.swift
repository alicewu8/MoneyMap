//
//  PurchaseInfo.swift
//  money-mapp
//
//  Created by Alice Wu on 8/5/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import Foundation
import UIKit

class PurchaseInfo : UIViewController {
    
    @IBOutlet weak var purchase_label: UILabel!
    @IBOutlet weak var return_button: UIButton!
    @IBOutlet weak var list_view: UIView!
    @IBOutlet weak var stars_bar: UIView!
    @IBOutlet weak var one_star: UIButton!
    @IBOutlet weak var two_star: UIButton!
    @IBOutlet weak var three_star: UIButton!
    @IBOutlet weak var four_star: UIButton!
    @IBOutlet weak var five_star: UIButton!
    
    var stars : [UIButton] = []
    
    override func viewDidLoad() {
        initializeStars()
    }
    
    func initializeStars() {
        stars.append(one_star)
        stars.append(two_star)
        stars.append(three_star)
        stars.append(four_star)
        stars.append(five_star)
        
        var rating = 1
        
        for i in 0..<stars.count {
            stars[i].tag = rating
            rating += 1
        }
    }
    
    @IBAction func starSelected(_ sender: UIButton) {
        let rating = sender.tag
        
        let i = 1
        while i <= rating {
            // change the image to the filled-in star
            stars[i - 1].setImage(UIImage(named: "favorite"), for: .normal)
        }
    }
}
