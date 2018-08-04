//
//  ViewController.swift
//  money-mapp
//
//  Created by Alice Wu on 7/10/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController, UITabBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    // MARK: collection view
    @IBOutlet weak var collection_view: UICollectionView!
    
    // MARK: views
    @IBOutlet weak var title_view: UIView!
    
    // MARK: tab bar
    @IBOutlet weak var tab_bar: UITabBar!
    
    // array of purchase categories
    var categories : [Category] = []
    
    // tracks the id of the category to delete
    var category_to_delete : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This view controller is the delegate and datasource for the collection view
        collection_view.delegate = self
        collection_view.dataSource = self
        
        initializeCategories()
        formatViews()
        formatCells()
        formatTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Default purchase categories (for testing)
    func initializeCategories() {
        categories.append(Category(name: "Clothes", image: UIImage(named: "clothes_icon")!, id: 0, selected: false, budget: 10, running_total: 0, purchases: []))
        categories.append(Category(name: "Eating Out", image: UIImage(named: "food_icon")!, id: 1, selected: false, budget: 50, running_total: 25, purchases: []))
        categories.append(Category(name: "Groceries", image: UIImage(named: "groceries_icon")!, id: 2, selected: false, budget: 80, running_total: 70, purchases: []))
        categories.append(Category(name: "Coffee", image: UIImage(named: "coffee_icon")!, id: 3, selected: false, budget: nil, running_total: 0, purchases: []))
        categories.append(Category(name: "Gas", image: UIImage(named: "car_icon")!, id: 4, selected: false, budget: nil, running_total: 0, purchases: []))
        categories.append(Category(name: "Gifts", image: UIImage(named: "gift_icon")!, id: 5, selected: false, budget: nil, running_total: 0, purchases: []))
    }
    
    func formatViews() {
        collection_view.layer.backgroundColor = Canvas.super_light_gray.cgColor
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
        if segue.identifier == "to_delete_category" {
            let delete_cat = segue.destination as! ConfirmDeleteCategory
            delete_cat.categories_vc = self
        } else if segue.identifier == "to_expense_recording" {
            guard let selected_cell = sender as? CategoryCollectionViewCell, let selected_row_index = collection_view.indexPath(for: selected_cell)?.row else { return }
            
            // track the category selected and pass information to next view controller
            let expense_category = categories[selected_row_index]
            let expense_vc = segue.destination as! ExpensesVC
            expense_vc.category = expense_category
        } else if segue.identifier == "to_add_budget" {
            let add_budget = segue.destination as! AddBudgetVC
            add_budget.categories_vc = self
        }
    }
    
    // MARK: Collection view
    // Populates the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    // Helper function: determines cell color based on remaining budget
    /* 0 = default, 1 = green, 2 = orange, 3 = red */
    func budgetStatusColor(_ category: Category) -> Int {
        // first, check that a budget has been instantiated
        // TODO: prompt user for budget
        guard let budget = category.budget else { return 0 }
        
        if category.running_total < budget / 2 {
            return 1
        } else if category.running_total < budget * 0.8 {
            return 2
        } else {
            return 3
        }
    }
    
    // TODO: make a function that checks for spending past your limit
    // If you have only $20 left in your budget, a separate view controller pops up with a warning message

    // Initializes a category collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category_cell", for: indexPath) as! CategoryCollectionViewCell
        
        // set the cell data and modify appearance
        let cell_data = categories[indexPath.row]
        cell.category_label.text = cell_data.name
        cell.category_image_view.image = cell_data.image
        cell.category = cell_data
        cell.delete_button.isHidden = true
        
        cell.roundCorners()
        
        // set the cell's color based on the current spending amount
        switch budgetStatusColor(cell.category) {
            case 1:
                cell.layer.backgroundColor = Canvas.aurora_green.cgColor
            case 2:
                cell.layer.backgroundColor = Canvas.peach.cgColor
            case 3:
                cell.layer.backgroundColor = Canvas.lipstick.cgColor
            default:
                print("Default Storyboard color--no budget instantiated")
        }
        
        // modify cell member variables
        cell.parent = self
        cell.index_path = indexPath
        
        // add gesture recognizers
        cell.addTap()
        cell.addLongPress()
        
        return cell
    }
    
    // Highlights border to indicate selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collection_view.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        
        cell.layer.borderColor = Canvas.golden_sand.cgColor
        cell.layer.borderWidth = 2
        
        // segue into the VC responsible for expense tracking
        performSegue(withIdentifier: "to_expense_recording", sender: self)
        // think about how to do this--use a xib file and load the one according to the selected category
        
        // for custom categories: record the string and use a default image? Or have user choose an image (do later)
    }
    
    // Reverts the border to unselected state
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collection_view.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        
        cell.layer.borderColor = Canvas.watermelon_red.cgColor
        cell.layer.borderWidth = 0.5
    }
    
    // MARK: Category add/delete
    func confirmCategoryDeletion(_ category: Category) {
        category_to_delete = category.id
        
        // segue to the confirmation popup
        performSegue(withIdentifier: "to_delete_category", sender: self)
    }
    
    // searches categories array for the object to delete
    func deleteCategory() {
        for i in 0..<categories.count {
            if categories[i].id == category_to_delete {
                categories.remove(at: i)
                // exit loop once element is removed
                break
            }
        }
        collection_view.reloadData()
        // animate the collection view refreshing
//        collection_view.performBatchUpdates({
//            self.collection_view.reloadSections(IndexSet(integer: 0))
//        }, completion: nil)
    }
    
    // MARK: tab bar
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // represents the tab bar item the user selected
        let selected_ind = tab_bar.items?.index(of: item)
        
        switch selected_ind {
            case 0:
                print("Expense recording")
            case 1:
                print("Analyze spending")
            case 2:
                print("Settings: change UI, adjust variables, etc.")
            default:
                print("tab bar")
        }
    }
    
    // Add budget to a category
    
}
