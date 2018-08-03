//
//  ViewController.swift
//  money-mapp
//
//  Created by Alice Wu on 7/10/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController, UITabBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var title_view: UIView!
    @IBOutlet weak var tab_bar: UITabBar!
    
    var categories : [Category] = []
    
    // tracks the id of the category to delete
    var category_to_delete : Int?
    //let categories = ["Clothes", "Eating Out", "Groceries", "Coffee", "Gas", "Gifts"]
    
    // Array of images from Assets folder
    //var category_images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
    // TODO: do I need this? Status bar time/date wouldn't show
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Default purchase categories (for testing)
    func initializeCategories() {
        categories.append(Category(name: "Clothes", image: UIImage(named: "clothes_icon")!, id: 0, selected: false))
        categories.append(Category(name: "Eating Out", image: UIImage(named: "food_icon")!, id: 1, selected: false))
        categories.append(Category(name: "Groceries", image: UIImage(named: "groceries_icon")!, id: 2, selected: false))
        categories.append(Category(name: "Coffee", image: UIImage(named: "coffee_icon")!, id: 3, selected: false))
        categories.append(Category(name: "Gas", image: UIImage(named: "car_icon")!, id: 4, selected: false))
        categories.append(Category(name: "Gifts", image: UIImage(named: "gift_icon")!, id: 5, selected: false))
    }
    
    func formatViews() {
        collection_view.layer.backgroundColor = Canvas.watermelon_red.cgColor
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
        tab_bar.barTintColor = Canvas.watermelon_red
        
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
            let expense = segue.destination as! ExpensesVC
            
        }
    }
    
    // MARK: Collection view
    // Populates the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    // Initializes a category collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category_cell", for: indexPath) as! CategoryCollectionViewCell
        
        // set the cell data and modify appearance
        let cell_data = categories[indexPath.row]
        cell.category_label.text = cell_data.name
        cell.category_image_view.image = cell_data.image
        cell.category = cell_data
        cell.delete_button.isHidden = true
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = Canvas.watermelon_red.cgColor
        cell.roundCorners()
        
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
        
        cell.layer.borderColor = Canvas.sky_blue.cgColor
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
        print("tab bar! Work on this!")
    }
}
