//
//  ConfirmDeleteCategory.swift
//  money-mapp
//
//  Created by Alice Wu on 8/2/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class ConfirmDeleteCategory : UIViewController {
    
    @IBOutlet weak var confirmation_window: UIView!
    @IBOutlet weak var buttons_view: UIView!
    @IBOutlet weak var yes_btn: UIButton!
    @IBOutlet weak var no_btn: UIButton!
    
    var categories_vc : CategoriesVC!
    
    override func viewDidLoad() {
        formatViews()
        formatButtons()
    }
    
    func formatViews() {
        confirmation_window.roundCorners(7.5)
        confirmation_window.layer.borderWidth = 3
        confirmation_window.layer.borderColor = Canvas.watermelon_red.cgColor
        
        yes_btn.roundCorners(7.5)
        no_btn.roundCorners(7.5)
    }
    
    func formatButtons() {
        yes_btn.showsTouchWhenHighlighted = true
        no_btn.showsTouchWhenHighlighted = true
    }
    
    @IBAction func deleteConfirmed(_ sender: Any) {
        categories_vc.deleteCategory()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissDelete(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        categories_vc.collection_view.reloadData()
    }
}
