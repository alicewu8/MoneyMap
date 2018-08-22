//
//  ViewController.swift
//  money-mapp
//
//  Created by Alice Wu on 7/10/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

// Expand budget label and give three sig figures
class CategoriesVC: UIViewController, UITabBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var confirm_change_view: UIView!
    @IBOutlet weak var confirm_change_message: UILabel!
    
    @IBOutlet weak var yes_button: UIButton!
    @IBOutlet var whole_view: UIView!
    @IBOutlet weak var no_button: UIButton!
    
    // MARK: collection view
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var blur_view: UIVisualEffectView!
    
    var blur_effect : UIVisualEffect!
    
    // MARK: state variables
    var add : Bool = false
    var confirm_window_displayed : Bool = false
    
    // MARK: views
    @IBOutlet weak var title_view: UIView!
    
    // MARK: tab bar
    @IBOutlet weak var tab_bar: UITabBar!
    @IBOutlet weak var add_category_button: UIButton!
    
    // MARK: transparent views for animations
    @IBOutlet weak var add_outer: UIView!
    @IBOutlet weak var settings_outer: UIView!
    
    // array of purchase categories
    var categories : [Category] = []

    // represents the collection view cell currently generated
    var current_cell : CategoryCollectionViewCell!
    
    // tracks the id of the category to delete
    var category_to_delete : Int?
    
    var selected_category_index : Int?
    
    // Records purchase history
    // Dictionary that maps from category index to an array of purchases
    // initialize a dictionary that maps from a category's index in the categories array to the purchases made in that category
    var history = [Int:[Purchase]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This view controller is the delegate and datasource for the collection view
        collection_view.delegate = self
        collection_view.dataSource = self
        
        initializeCategories()
        initializeHistory()
        formatViews()
        formatCells()
        formatTabBar()
        
        // store the blue effect and disable it on start up
        blur_effect = blur_view.effect
        blur_view.effect = nil
        
        confirm_change_view.roundCorners(7.5)
        
        yes_button.roundCorners(7.5)
        no_button.roundCorners(7.5)
        
        // Record will be highlighted on startup
        tab_bar.selectedItem = tab_bar.items?.first
    }
    
    func initializeHistory() {
        // initialize the key (index of a category in the categories array) to an empty array to allow modification later
        for i in 0..<categories.count {
            history[i] = []
        }
        print(history.count)
    }
    
    // MARK: animations for displaying confirmation window
    func animateIn() {
        confirm_window_displayed = true
        // NOTE: it wasn't centering because I gave it constraints
        // position it in the view
        confirm_change_view.center = CGPoint(x: collection_view.frame.width / 2, y: collection_view.frame.height / 2)
        
        self.collection_view.addSubview(confirm_change_view)
        
        // slightly increase the size to account for the animation (scales down the size)
        confirm_change_view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        confirm_change_view.roundCorners(7.5)
        
        // make invisible
        confirm_change_view.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.blur_view.effect = self.blur_effect
            self.confirm_change_view.alpha = 1
            
            // restore its previous size
            self.confirm_change_view.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        confirm_window_displayed = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.confirm_change_view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.confirm_change_view.alpha = 0
            
            self.blur_view.effect = nil
        }) { (success: Bool) in
            self.confirm_change_view.removeFromSuperview()
        } // completion block: executes after animation block has run
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Default purchase categories (for testing)
    func initializeCategories() {
        categories.append(Category(name: "Clothes", image: UIImage(named: "shirt")!, id: 0, selected: false, budget: 10, running_total: 0, purchases: []))
        
        categories.append(Category(name: "Eating Out", image: UIImage(named: "food_icon")!, id: 1, selected: false, budget: 50, running_total: 25, purchases: []))
        
        // testing sort
        categories.append(Category(name: "Groceries", image: UIImage(named: "groceries_icon")!, id: 2, selected: false, budget: 80, running_total: 70, purchases: [Purchase(name: "Vegetables", cost: 20, date: "8/09/18", info: "MHealthy Farmer's Market", id: 0), Purchase(name: "Bread", cost: 4, date: "8/01/18", info: "for Justin", id: 1), Purchase(name: "Grocery run", cost: 30, date: "8/05/18", info: "", id: 5), Purchase(name: "Soymilk", cost: 3.25, date: "8/02/18", info: "Unsweetened for Dad", id: 2), Purchase(name: "Lychees", cost: 3.29, date: "8/02/18", info: "", id: 3), Purchase(name: "Meijer Haul", cost: 40, date: "8/05/18", info: "", id: 4)
            ]))
        
        categories.append(Category(name: "Cosmetics", image: UIImage(named: "cosmetics")!, id: 3, selected: false, budget: nil, running_total: 0, purchases: []))
        
        categories.append(Category(name: "Travel", image: UIImage(named: "paper_plane")!, id: 4, selected: false, budget: nil, running_total: 0, purchases: []))
        
        categories.append(Category(name: "Gifts", image: UIImage(named: "gifts")!, id: 5, selected: false, budget: nil, running_total: 0, purchases: []))
    }
    
    // MARK: handle category addition/deletion actions
    @IBAction func pressedYesButton(_ sender: Any) {
        if add {
            print("implement category adding")
        } else {
            deleteCategory()
        }
        animateOut()
    }
    
    @IBAction func pressedNoButton(_ sender: Any) {
        animateOut()
        if !add {
            current_cell.removeWiggleAnimation(current_cell)
        }
    }
    
    func formatViews() {
        collection_view.layer.backgroundColor = UIColor.white.cgColor
        
        // make it a circle
        settings_outer.roundCorners(settings_outer.frame.width / 2)
        settings_outer.alpha = 0
        add_outer.roundCorners(add_outer.frame.width / 2)
        add_outer.alpha = 0
    }
    
    func formatCells() {
        let layout = self.collection_view.collectionViewLayout as! UICollectionViewFlowLayout
        
        // create spacing between cells
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        
        // splits each row between two cells
        layout.itemSize = CGSize(width: (self.collection_view.frame.size.width - 20) / 2, height: self.collection_view.frame.size.height / 3)
    }
    
    func formatTabBar() {
        tab_bar.delegate = self
        
        let appearance = UITabBarItem.appearance()
        
        // modifies the font of each tab bar item label
        let attributes = [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_expense_recording" {
            let expense_vc = segue.destination as! ExpensesVC
            //expense_vc.category = expense_category
            expense_vc.categories_vc = self
            expense_vc.category_index = selected_category_index
            expense_vc.category = categories[selected_category_index!]
        } else if segue.identifier == "to_add_budget" {
            let add_budget = segue.destination as! AddBudgetVC
            add_budget.categories_vc = self
            add_budget.category_cell = current_cell
            add_budget.category_index = selected_category_index
        } 
    }
    
    @IBAction func addCategory(_ sender: Any) {
        // animate the circular background view
        UIView.animate(withDuration: 0.4, animations: {
            self.add_outer.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.add_outer.alpha = 1
        }) { (success: Bool) in
            // restore to its previous size and disappear it
            self.add_outer.transform = CGAffineTransform.identity
            self.add_outer.alpha = 0
        }
        
        if !confirm_window_displayed {
            confirm_change_message.text = "Do you want to add a new category?"
            add = true
            animateIn()
            confirm_window_displayed = true
        }
    }
    
    @IBAction func openSettings(_ sender: Any) {
        // animate the circular background view
        UIView.animate(withDuration: 0.4, animations: {
            self.settings_outer.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.settings_outer.alpha = 1
        }) { (success: Bool) in
            // restore to its previous size and disappear it
            self.settings_outer.transform = CGAffineTransform.identity
            self.settings_outer.alpha = 0
        }
    }
    
    // update the budget for the selected category
    // bug fix: search by name instead of ID to prevent falsely assigning budgets
    func updateBudget(_ category_id: Int, _ budget: Double) {
        for i in 0..<categories.count {
            // search for this category and modify its budget
            if categories[i].id == category_id {
                categories[i].budget = budget
            }
        }
        collection_view.reloadData()
    }
    
    // MARK: Tab bar
    // Using a tab bar instead of tab bar controller to pass information between view controllers in a more straight-forward way
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // represents the item that was tapped
        let ind = tabBar.items?.index(of: item)
        
        // prevent going out of bounds
        if ind! >= tab_bar.items!.count {
            return
        }
        
        switch ind {
        case 0:
            print("Record view")
        case 1:
            print("Analyze view")
        case 2:
            print("History view")
        default:
            print("Hi")
        }
    }
    
    // TODO: make a function that checks for spending past your limit
    // If you have only $20 left in your budget, a separate view controller pops up with a warning message
    
    // MARK: Collection view
    // Populates the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    // Initializes a category collection view cell
    // TODO! Move the UI edits to a function in CategoryCollectionViewCell.swift
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index_in_array = indexPath.row
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category_cell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.initialize(categories[index_in_array], self)
        
        // modify cell member variables
        cell.index_path = indexPath
        
        // copy the cell to the member variable
        current_cell = cell
        
        return cell
    }
    
    // Highlights border to indicate selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collection_view.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        
        //cell.layer.borderColor = Canvas.golden_sand.cgColor
        //cell.layer.backgroundColor = Canvas.french_sky_blue.cgColor
        
        // TODO: change the alpha from 0.5 to 1.0
        let color = UIColor(cgColor: cell.layer.backgroundColor!)
        
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.backgroundColor = color.withAlphaComponent(0.5).cgColor
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (success: Bool) in
            cell.layer.backgroundColor = color.cgColor
            cell.transform = CGAffineTransform.identity
        }
        
        // segue into the VC responsible for expense tracking
        performSegue(withIdentifier: "to_expense_recording", sender: self)
        
        // for custom categories: record the string and use a default image? Or have user choose an image (do later)
    }
    
    // MARK: Category add/delete
    func confirmCategoryDeletion(_ category: Category) {
        category_to_delete = category.id
        
        // segue to the confirmation popup
        confirm_change_message.text = "Delete this category?"
        animateIn()
    }
    
    // searches categories array for the object to delete
    func deleteCategory() {
        for i in 0...categories.count {
            if categories[i].id == category_to_delete {
                categories.remove(at: i)
                // exit loop once element is removed
                break
            }
        }
        collection_view.reloadData()
    }
}
