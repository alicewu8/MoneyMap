//
//  ExpensesVC.swift
//  money-mapp
//
//  Created by Alice Wu on 8/2/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class ExpensesVC : UIViewController, UITextFieldDelegate, UITableViewDelegate {
    
    var categories_vc : CategoriesVC!
    
    // TODO: each category needs an array that holds expenses and a variable to track budget
    // Think of a better way to allocate this
    var category : Category!
    
    @IBOutlet weak var done_btn: UIButton!
    
    override func viewDidLoad() {
        done_btn.roundCorners(7.5)
        done_btn.layer.borderWidth = 1.5
        done_btn.layer.borderColor = Canvas.watermelon_red.cgColor
    }
    
    
    // return to the category selection screen
    @IBAction func doneEditing(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
