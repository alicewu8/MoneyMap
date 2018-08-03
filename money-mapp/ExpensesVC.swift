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
    
}
