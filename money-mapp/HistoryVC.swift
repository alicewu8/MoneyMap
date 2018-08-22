//
//  HistoryVC.swift
//  money-mapp
//
//  Created by Alice Wu on 8/21/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import Foundation
import UIKit

class HistoryVC : UIViewController {
    
    var categories_vc : CategoriesVC!
    var expenses_vc : ExpensesVC!
    
    var parent_tab_bar : MainTabBarController!
    override func viewDidLoad() {
        parent_tab_bar = tabBarController as! MainTabBarController
    }
    
}
