//
//  ExpensesVC.swift
//  money-mapp
//
//  Created by Alice Wu on 8/2/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class ExpensesVC : UIViewController {
    
    @IBOutlet weak var sort_button: UIButton!
    @IBOutlet weak var budget_status_bar: UIImageView!
    @IBOutlet weak var budget_remaining_label: UILabel!
    
    // MARK: layout constraints
    @IBOutlet weak var budget_status_bar_height: NSLayoutConstraint!
    @IBOutlet weak var budget_remaining_height: NSLayoutConstraint!
    @IBOutlet weak var category_name_top_space: NSLayoutConstraint!
    
    // MARK: sort options view
    @IBOutlet var sort_options_view: UIView!
    @IBOutlet weak var option_one_view: UIView!
    @IBOutlet weak var option_one_label: UILabel!
    @IBOutlet weak var separator_one: UIView!
    @IBOutlet weak var option_one_button: UIButton!
    
    @IBOutlet weak var option_two_view: UIView!
    @IBOutlet weak var option_two_label: UILabel!
    @IBOutlet weak var separator_two: UIView!
    @IBOutlet weak var option_two_button: UIButton!
    
    @IBOutlet weak var option_three_view: UIView!
    @IBOutlet weak var option_three_label: UILabel!
    @IBOutlet weak var option_three_button: UIButton!
    
    @IBOutlet var background_view: UIView!
    @IBOutlet weak var message_view: UIView!
    
    @IBOutlet weak var slider: UIView!
    
    // MARK: transparent background views for animations
    @IBOutlet weak var sort_outer: UIView!
    @IBOutlet weak var switch_outer: UIView!
    
    // Superview that will contain either the grid or list view
    @IBOutlet weak var expenses_view: UIView!
    var expenses_grid : ExpensesGridView!
    var expenses_list : ExpensesListView!
    
    @IBOutlet weak var category_name: UILabel!
    @IBOutlet weak var switch_layout_button: UIButton!
    
    // MARK: state variables
    var using_grid : Bool
    var initial_touch_point : CGPoint = CGPoint(x: 0, y: 0)
    var added_sort_view : Bool = false
    var first_sort : Bool = true
    
    var categories_vc : CategoriesVC!
    var category : Category!
    var category_index : Int!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_add_purchase" {
            let add_purchase = segue.destination as! AddPurchaseVC
            add_purchase.expenses_vc = self
            add_purchase.category = category
            add_purchase.category_index = category_index
        } else if segue.identifier == "to_purchase_info" {
            let purchase_info = segue.destination as! PurchaseInfo
            purchase_info.expenses_vc = self
        } else if segue.identifier == "to_customize" {
            let customize_info = segue.destination as! CustomizeVC
            customize_info.categories_vc = categories_vc
        }
    }
    
    override func viewDidLoad() {
        background_view.layer.backgroundColor = Canvas.super_light_gray.cgColor
        
        category_name.text = category.name
        expenses_view.layer.backgroundColor = Canvas.super_light_gray.cgColor
        
        budget_status_bar.roundCorners()
        
        updateBudgetBar()
        updateBudgetLabel()
        
        // make the background views circular and hidden
        sort_outer.roundCorners(sort_outer.frame.width / 2)
        sort_outer.alpha = 0
        
        switch_outer.roundCorners(switch_outer.frame.width / 2)
        switch_outer.alpha = 0
        
        // add a pan gesture recognizer to support swiping the screen to dismiss
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panScreen(_:)))
        view.addGestureRecognizer(pan)
        
        sort_options_view.roundCorners()
        sort_options_view.frame.size.height = 0
        
        // don't round these corners
        sort_options_view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        option_one_button.tag = 1
        option_two_button.tag = 2
        option_three_button.tag = 3
        
        expenses_view.layer.backgroundColor = Canvas.super_light_gray.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showCustomizations(_:)))
        category_name.isUserInteractionEnabled = true
        category_name.addGestureRecognizer(tap)
        
        slider.roundCorners()
        // don't round these corners
        slider.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    // default to showing the grid view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let purchases_list = Bundle.main.loadNibNamed("ExpensesListView", owner: self, options: nil)?.first as? ExpensesListView else { return }
        
        // store this in the member variable
        expenses_list = purchases_list
        
        // set frame equal to the superview
        expenses_list?.frame.size = expenses_view.frame.size
        expenses_view?.addSubview(expenses_list!)
        expenses_list?.initialize(self)
        expenses_list.layer.backgroundColor = Canvas.super_light_gray.cgColor
        view.layoutIfNeeded()
    }
    
    @objc func showCustomizations(_ sender: UITapGestureRecognizer) {
        // animate the category name and arrow image alpha decreasing
        
        performSegue(withIdentifier: "to_customize", sender: self)
    }
    
    @IBAction func sortMethodSelected(_ sender: UIButton) {
        // check for purchases to sort: prevent crash
        guard categories_vc.categories[category_index].purchases.count > 0 else { return }
        
        if sender.tag == 1 {
            print("Price low to high")
            let color = UIColor(cgColor: self.option_one_view.layer.backgroundColor!)
            UIView.animate(withDuration: 0.3, animations: {
                self.option_one_view.layer.backgroundColor = color.withAlphaComponent(1.5).cgColor
            })
            { (success: Bool) in
                self.option_one_view.backgroundColor = color
            }
            
            // replace the current purchases array with the sorted array
            categories_vc.categories[category_index
                ].purchases = insertionSort(categories_vc.categories[category_index
                    ].purchases, true)
            
        } else if sender.tag == 2 {
            print("Price high to low")
            
            // replace the current purchases array with the sorted array
            // FIXME: fix increasing order
            categories_vc.categories[category_index
                ].purchases = insertionSort(categories_vc.categories[category_index
                    ].purchases, false)
            
        } else if sender.tag == 3 {
            print("Newest")
        }
        
        // animate updating the data to reflect the sort
        if using_grid {
            expenses_grid.refreshInfo()
        } else {
            expenses_list.refreshInfo()
        }
    }
    
    @IBAction func showSortOptions(_ sender: Any) {
        print("sort pressed")
       
        // animate the circular background view
        UIView.animate(withDuration: 0.4, animations: {
            self.sort_outer.transform = CGAffineTransform(scaleX: 1.38, y: 1.38)
            self.sort_outer.alpha = 1
        }) { (success: Bool) in
            // restore to its previous size and disappear it
            self.sort_outer.transform = CGAffineTransform.identity
            self.sort_outer.alpha = 0
        }
        
        if sort_button.titleLabel?.text == "Sort +" {
            sort_button.setTitle("Sort -", for: .normal)
            // y value should be below safe area (20) + intro message height (64) = 84
            sort_options_view.frame.origin.y = 84
            
            // have the x align with the sort button's leading
            sort_options_view.frame.origin.x = 20
            
            self.view.addSubview(self.sort_options_view)
            
            // animate the height change
            UIView.transition(with: self.view, duration: 0.4, options: UIView.AnimationOptions.curveEaseIn,
                    animations: {
                        self.sort_options_view.frame.size.height = 140
                        //self.sort_options_view.alpha = 1
            }, completion: nil)
            view.layoutSubviews()
            
            added_sort_view  = true
        } else {
            sort_button.setTitle("Sort +", for: .normal)
            
            UIView.transition(with: self.view, duration: 0.3, options: UIView.AnimationOptions.curveEaseIn,
                              animations: {
                                self.sort_options_view.frame.size.height = 0
                                
                                // AWESOME! Prevents constraints from messing up the view
                                self.view.layoutIfNeeded()
            }) { (success: Bool) in
                self.view.subviews.last?.removeFromSuperview()
            }
            view.layoutSubviews()
        }
    }
    
    // vertically displaces this screen and handles swipe to dismiss
    @objc func panScreen(_ sender: UIPanGestureRecognizer) {
        // stores the origin of the pan gesture
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizer.State.began {
            initial_touch_point = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            // only move the screen with a down swipe
            if touchPoint.y - initial_touch_point.y > 0 {
                // displace by the vertical delta between the new touch and the initial
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initial_touch_point.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            // dismiss the screen if it is dragged by more than 100 pixels
            if touchPoint.y - initial_touch_point.y > 100 {
                self.dismiss(animated: true, completion: nil)
                
                // reverts the border color
                categories_vc.collection_view.reloadData()
            } else {
                // revert its position to the top
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    // assigns the corresponding budget remaining image by percentage
    func updateBudgetBar() {
        guard let budget = categories_vc.categories[category_index].budget else { return }
        let total_spent = categories_vc.categories[category_index].running_total 
        
        // Super painful hardcoding. Think of how to improve
        // TODO: implement warning bar when budget is exceeded
        if total_spent == 0 {
            budget_status_bar.image = UIImage(named: "budget_0")
        } else if total_spent <= budget * 0.1 {
            budget_status_bar.image = UIImage(named: "budget_10")
        } else if total_spent <= budget * 0.2 {
            budget_status_bar.image = UIImage(named: "budget_20")
        } else if total_spent <= budget * 0.3 {
            budget_status_bar.image = UIImage(named: "budget_30")
        } else if total_spent <= budget * 0.4 {
            budget_status_bar.image = UIImage(named: "budget_40")
        } else if total_spent <= budget * 0.5 {
            budget_status_bar.image = UIImage(named: "budget_50-1")
        } else if total_spent <= budget * 0.6 {
            budget_status_bar.image = UIImage(named: "budget_60")
        } else if total_spent <= budget * 0.7 {
            budget_status_bar.image = UIImage(named: "budget_70")
        } else if total_spent <= budget * 0.8 {
            budget_status_bar.image = UIImage(named: "budget_80")
        } else if total_spent <= budget * 0.9 {
            budget_status_bar.image = UIImage(named: "budget_90")
        } else {
            budget_status_bar.image = UIImage(named: "budget_100")
        }
        
        //if money_spent
        
        
    }
    
    func updateBudgetLabel() {
        // check for nil budget: only execute if a budget is instantiated
        guard let budget = categories_vc.categories[category_index].budget else { return }
        let running_total = categories_vc.categories[category_index].running_total
    
        // FIXME: need to use categories_vc access variable
        self.budget_remaining_label.text = "$" + String(format: "%.2f", budget - running_total) + " of $" + String(format: "%.2f", self.category.budget!) + " left"
        self.budget_remaining_label.font = UIFont(name: "AvenirNext-Medium", size: 15)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        // initialize member bool values
        self.using_grid = false
        
        super.init(coder: aDecoder)
    }
    
    func addNewPurchase(_ purchase: Purchase, _ category_index : Int) {
        // append this purchase to the category's purchases array
        categories_vc.categories[category_index].purchases.append(purchase)
        
        // update the category's running_total
        categories_vc.categories[category_index].running_total += purchase.cost
        
        updateBudgetBar()
        updateBudgetLabel()
    
        // Animate adding a new cell
        if using_grid {
            expenses_grid.refreshInfo()
        } else {
            expenses_list.refreshInfo()
        }
    }
    
    @IBAction func switchPurchaseLayout(_ sender: Any) {
        // animate the circular background view
        UIView.animate(withDuration: 0.4, animations: {
            self.switch_outer.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.switch_outer.alpha = 1
        }) { (success: Bool) in
            // restore to its previous size and disappear it
            self.switch_outer.transform = CGAffineTransform.identity
            self.switch_outer.alpha = 0
        }
        
        if !using_grid {
            // remove the previous
            expenses_view.subviews.last?.removeFromSuperview()
            
            addExpensesGrid()
            
            switch_layout_button.setImage(UIImage(named: "list"), for: .normal)
            using_grid = true
        } else {
            expenses_view.subviews.last?.removeFromSuperview()
            
            addExpensesList()
            
            switch_layout_button.setImage(UIImage(named: "grid"), for: .normal)
            using_grid = false
        }
    }
    
    func addExpensesGrid() {
        guard let purchases_grid = Bundle.main.loadNibNamed("ExpensesGridView", owner: self, options: nil)?.first as? ExpensesGridView else { return }
        
        // store this in the member variable
        expenses_grid = purchases_grid
        
        // set frame equal to the superview
        expenses_grid.frame.size = expenses_view.frame.size
        expenses_view.addSubview(expenses_grid)
        expenses_grid.initialize(self)
        view.layoutIfNeeded()
    }
    
    // loads the expenses list from nib and fits it to the expenses view
    func addExpensesList() {
        guard let purchases_list = Bundle.main.loadNibNamed("ExpensesListView", owner: self, options: nil)?.first as? ExpensesListView else { return }
        
        // store this in the member variable
        expenses_list = purchases_list
        
        // set frame equal to the superview
        expenses_list?.frame.size = expenses_view.frame.size
        expenses_view?.addSubview(expenses_list!)
        expenses_list.layer.backgroundColor = Canvas.super_light_gray.cgColor
        expenses_list?.initialize(self)
        view.layoutIfNeeded()
    }
}
