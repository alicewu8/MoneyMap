//
//  ViewController.swift
//  money-mapp
//
//  Created by Alice Wu on 7/10/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class CategorySelector: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    @IBOutlet weak var collection_view: UICollectionView!
    
    let categories = ["Clothes", "Eating Out", "Groceries", "Coffee", "Gas", "Home", "Gifts"]
    
    // Array of images from Assets folder
    var category_images: [UIImage] = [
//        UIImage(named: "clothes_icon")!,
//        UIImage(named: "food_icon")!,
//        UIImage(named: "groceries_icon")!,
//        UIImage(named: "coffee_icon")!,
//        UIImage(named: "car_icon")!,
//        UIImage(named: "house_icon")!,
//        UIImage(named: "gift_icon")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // This view controller is the delegate and datasource for the collection view
        collection_view.delegate = self
        collection_view.dataSource = self
        
        populateImageArray()
    }
    
    func populateImageArray() {
        category_images.append(UIImage(named: "clothes_icon")!)
        category_images.append(UIImage(named: "food_icon")!)
        category_images.append(UIImage(named: "groceries_icon")!)
        category_images.append(UIImage(named: "coffee_icon")!)
        category_images.append(UIImage(named: "car_icon")!)
        category_images.append(UIImage(named: "house_icon")!)
        category_images.append(UIImage(named: "gift_icon")!)
    }
    
    // Populates the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    // Loads a collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category_cell", for: indexPath) as! CategoryCollectionViewCell
        
        // set the cell data
        cell.category_label.text = categories[indexPath.item]
        cell.category_image_view.image = category_images[indexPath.item]
        
        return cell
    }
    


}

