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
    
    @IBOutlet weak var budget_status_bar: UIImageView!
    @IBOutlet weak var budget_remaining_label: UILabel!
    // MARK: layout constraints
    @IBOutlet weak var budget_status_bar_height: NSLayoutConstraint!
    @IBOutlet weak var budget_remaining_height: NSLayoutConstraint!
    @IBOutlet weak var category_name_top_space: NSLayoutConstraint!
    
    // MARK: state variables
    var using_grid : Bool
    var showing_status_bar : Bool
    
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
        expenses_view.layer.backgroundColor = Canvas.super_light_gray.cgColor
        
        initializeLabels()
    }
    
    func initializeLabels() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showBudgetRemaining(_:)))
        
        // set the labels and image to receive user interaction events
        category_name.isUserInteractionEnabled = true
        //budget_status_bar.isUserInteractionEnabled = true
        //budget_remaining_label.isUserInteractionEnabled = true
        
        category_name.addGestureRecognizer(tap)
        //budget_status_bar.addGestureRecognizer(tap)
        //budget_remaining_label.addGestureRecognizer(tap)
    }
    
    @objc func showBudgetRemaining(_ sender: UITapGestureRecognizer) {
        // check for nil budget: only execute if a budget is instantiated
        guard category.budget != nil else { return }
        
        // animate the image/label height changes
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseIn, animations: {
            if self.showing_status_bar { // currently showing the battery bar: hide it and show the budget remaining label
                self.category_name_top_space.constant = 10
                self.budget_status_bar_height.constant = 0
                
                // initialize budget remaining label
                self.budget_remaining_label.text = "$" + String(format: "%.2f", self.category.running_total!) + " of $" + String(format: "%.2f", self.category.budget!) + " remaining"
                self.budget_remaining_label.font = UIFont(name: "AvenirNext-Medium", size: 15)
                self.budget_remaining_height.constant = 10
                self.showing_status_bar = false
            } else { // shrink the label and revert the image height
                // keep the category name in the same place
                self.category_name_top_space.constant = 10
                self.budget_remaining_height.constant = 0
                self.budget_status_bar_height.constant = 20
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
        
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
        self.showing_status_bar = true
        
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
        if !using_grid {
            // remove the previous
            expenses_view.subviews.last?.removeFromSuperview()
            switch_layout_button.setImage(UIImage(named: "grid"), for: .normal)
            using_grid = false
        } else {
            expenses_view.subviews.last?.removeFromSuperview()
            switch_layout_button.setImage(UIImage(named: "list_view"), for: .normal)
            using_grid = true 
        }
    }
    
}
