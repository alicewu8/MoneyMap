//
//  ExpensesVC.swift
//  money-mapp
//
//  Created by Alice Wu on 8/2/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class ExpensesVC : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var categories_vc : CategoriesVC!
    var category : Category!
    
    @IBOutlet weak var message_view: UIView!
    @IBOutlet weak var purchases_collection_view: UICollectionView!
    @IBOutlet weak var done_btn: UIButton!
    
    override func viewDidLoad() {
        done_btn.roundCorners(7.5)
        done_btn.layer.borderWidth = 1.5
        done_btn.layer.borderColor = Canvas.watermelon_red.cgColor
        
        initializeCollectionView()
     
        formatCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initializeCollectionView() {
        // set the delegate and datasource to ExpensesVC
        purchases_collection_view.delegate = self
        purchases_collection_view.dataSource = self
        
        // add the custom collection view cells to this collection view
        purchases_collection_view.register(UINib(nibName: "PurchasesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PurchaseCollectionViewCell.reuse_id)
        purchases_collection_view.register(UINib(nibName: "AddPurchaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AddPurchaseCollectionViewCell.reuse_id)
        
        purchases_collection_view.reloadData()
    }
    
    func formatCells() {
        let layout = self.purchases_collection_view.collectionViewLayout as! UICollectionViewFlowLayout
        
        // create spacing between cells
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        
        // splits each row between three cells
        layout.itemSize = CGSize(width: (self.purchases_collection_view.frame.size.width - 20) / 3, height: self.purchases_collection_view.frame.size.height / 3)
    }
    
    // MARK: collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // add an additional cell to be the add purchase cell
        return category.purchases.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // base case: no purchases
        if category.purchases.count == 0 {
            let add_cell = purchases_collection_view.dequeueReusableCell(withReuseIdentifier: AddPurchaseCollectionViewCell.reuse_id, for: indexPath) as! AddPurchaseCollectionViewCell
            //add_cell.initialize(parent: self)
            return add_cell
        } else {
            // store the index of this cell in the array
            let index = indexPath.row
            
            // use a purchase collection view cell
            if index <= category.purchases.count {
                let purchase_cell = purchases_collection_view.dequeueReusableCell(withReuseIdentifier: PurchaseCollectionViewCell.reuse_id, for: indexPath) as! PurchaseCollectionViewCell
                
                //purchase_cell.initialize(category: category, parent: self)
                
                return purchase_cell
            } else {
                let add_cell = purchases_collection_view.dequeueReusableCell(withReuseIdentifier: AddPurchaseCollectionViewCell.reuse_id, for: indexPath) as! AddPurchaseCollectionViewCell
                
                return add_cell
            }
        }
    }
    
    // return to the category selection screen
    @IBAction func doneEditing(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
