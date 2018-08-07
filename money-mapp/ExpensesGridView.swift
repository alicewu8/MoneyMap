//
//  PurchasesGridView.swift
//  money-mapp
//
//  Created by Alice Wu on 8/7/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import Foundation
import UIKit

class ExpensesGridView : UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // FIXED FILES'S OWNER PROBLEM: assign the class to the superview AND File's Owner
    @IBOutlet weak var purchases_collection: UICollectionView!
    
    var parent : ExpensesVC!
    var category_index : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
    }
    
    func initialize(_ parent: ExpensesVC) {
        self.parent = parent
        self.category_index = parent.category_index
        
        purchases_collection.layer.backgroundColor = Canvas.super_light_gray.cgColor
        
        purchases_collection.delegate = self
        purchases_collection.dataSource = self
        
        // add the custom collection view cells to this collection view
        purchases_collection.register(UINib(nibName: "PurchaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PurchaseCollectionViewCell.reuse_id)
        purchases_collection.register(UINib(nibName: "AddPurchaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AddPurchaseCollectionViewCell.reuse_id)
        
        purchases_collection.reloadData()
    }
    
    // MARK: collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 168)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let vert_space : CGFloat = 10
        
        var hor_space : CGFloat = 0
        if hor_space < 5 { hor_space = 40 }
        
        return UIEdgeInsets(top: vert_space, left: hor_space, bottom: vert_space, right: hor_space)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // add an additional cell to be the add purchase cell
        return parent.categories_vc.categories[category_index].purchases.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // base case: no purchases
        if parent.categories_vc.categories[category_index].purchases.count == 0 {
            let add_cell = purchases_collection.dequeueReusableCell(withReuseIdentifier: AddPurchaseCollectionViewCell.reuse_id, for: indexPath) as! AddPurchaseCollectionViewCell
            
            add_cell.initialize(parent: parent)
            return add_cell
        }
        
        // store the index of this cell in the array
        let index = indexPath.row
        
        // use a purchase collection view cell
        // FIXME: not using the modified copy--how to make this less error-prone? How to modify the parent's member variables by reference
        if index < parent.categories_vc.categories[category_index].purchases.count {
            let purchase_cell = purchases_collection.dequeueReusableCell(withReuseIdentifier: PurchaseCollectionViewCell.reuse_id, for: indexPath) as! PurchaseCollectionViewCell
            
            purchase_cell.initialize(category: parent.categories_vc.categories[category_index], parent: parent, purchase_id: index)
            
            return purchase_cell
        } else { // always include an add purchase cell
            let add_cell = purchases_collection.dequeueReusableCell(withReuseIdentifier: AddPurchaseCollectionViewCell.reuse_id, for: indexPath) as! AddPurchaseCollectionViewCell
            
            add_cell.initialize(parent: parent)
            
            return add_cell
        }
    }
    
    func refreshInfo() {
        purchases_collection.performBatchUpdates({
            self.purchases_collection.reloadSections(IndexSet(integer: 0))
        }, completion: nil)
    }
    
    func formatCells() {
        let layout = self.purchases_collection.collectionViewLayout as! UICollectionViewFlowLayout
        
        // create spacing between cells
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        
        // splits each row between three cells
        layout.itemSize = CGSize(width: (self.purchases_collection.frame.size.width - 20) / 4, height: self.purchases_collection.frame.size.height / 3)
    }
}
