//
//  ExpensesVC.swift
//  money-mapp
//
//  Created by Alice Wu on 8/2/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class ExpensesVC : UIViewController {
    
    var categories_vc : CategoriesVC!
    var category : Category!
    var category_index : Int!
    
    var using_grid : Bool
    var using_list : Bool
    
    @IBOutlet var background_view: UIView!
    @IBOutlet weak var message_view: UIView!
    
    // Superview that will contain either the grid or list view
    @IBOutlet weak var expenses_view: UIView!
    var expenses_grid : ExpensesGridView!
    var expenses_list : ExpensesListView?
    
    @IBOutlet weak var done_btn: UIButton!
    @IBOutlet weak var category_name: UILabel!
    @IBOutlet weak var switch_layout_button: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_add_purchase" {
            let add_purchase = segue.destination as! AddPurchaseVC
            add_purchase.expenses_vc = self
            add_purchase.category = category
            add_purchase.category_index = category_index
        } else if segue.identifier == "to_purchase_info" {
            let purchase_info = segue.destination as! PurchaseInfo
            purchase_info.expenses_vc = self
        }
    }
    
    override func viewDidLoad() {
        done_btn.roundCorners(7.5)
        done_btn.layer.borderWidth = 1.5
        done_btn.layer.borderColor = Canvas.watermelon_red.cgColor
        background_view.layer.backgroundColor = Canvas.super_light_gray.cgColor
        
        category_name.text = category.name
    }
    
    // TODO: testing
    func initializePurchases() {
        categories_vc.categories[category_index].purchases.append(Purchase(name: "Plane ticket", cost: 340.40, date: "8/07/18", info: "JetBlue", id: 0))
        categories_vc.categories[category_index].purchases.append(Purchase(name: "Dinner", cost: 340.40, date: "8/07/18", info: "JetBlue", id: 0))
    }
    
    // default to showing the grid view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let purchases_grid = Bundle.main.loadNibNamed("ExpensesGridView", owner: self, options: nil)?.first as? ExpensesGridView else { return }
        
        // store this in the member variable
        expenses_grid = purchases_grid
        
        // set frame equal to the superview
        expenses_grid.frame.size = expenses_view.frame.size
        expenses_view.addSubview(expenses_grid)
        expenses_grid.initialize(self)
        view.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // initialize member bool values
        self.using_grid = true
        self.using_list = false
        
        super.init(coder: aDecoder)
    }
    
    
    func addNewPurchase(_ purchase: Purchase, _ category_index : Int) {
        categories_vc.categories[category_index].purchases.append(purchase)
        
        // Animate adding a new cell
        if using_grid {
            expenses_grid.refreshInfo()
        } else {
            expenses_list?.reloadInputViews()
        }
    }
    
    // return to the category selection screen
    @IBAction func doneEditing(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        // reverts the border color
        categories_vc.collection_view.reloadData()
    }
    
    @IBAction func switchPurchaseLayout(_ sender: Any) {
    }
    
}
