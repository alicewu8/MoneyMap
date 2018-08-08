//
//  ConfirmDeleteCategory.swift
//  money-mapp
//
//  Created by Alice Wu on 8/2/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class ModifyCategory : UIViewController {
    
    @IBOutlet weak var confirmation_window: UIView!
    @IBOutlet weak var buttons_view: UIView!
    @IBOutlet weak var yes_btn: UIButton!
    @IBOutlet weak var no_btn: UIButton!
    @IBOutlet weak var confirmation_message: UILabel!
    
    var categories_vc : CategoriesVC!
    
    var delete : Bool!
    
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
        
        if delete {
            confirmation_message.text = "Do you want to delete this category?"
        } else {
            confirmation_message.text = "Do you want to add a new category?"
        }
    }
    
    func formatButtons() {
        yes_btn.showsTouchWhenHighlighted = true
        no_btn.showsTouchWhenHighlighted = true
    }
    
    @IBAction func confirmChange(_ sender: Any) {
        if delete {
            categories_vc.deleteCategory()
        } else { // add the subview that contains the textfield and confirmation button 
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissDelete(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        categories_vc.current_cell.removeWiggleAnimation(categories_vc.current_cell)
        //categories_vc.collection_view.layer.removeAllAnimations()
        //categories_vc.collection_view.reloadData()
        
        //categories_vc.collection_view.subviews.last?.removeFromSuperview()
    }
}
