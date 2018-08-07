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
    var category_index : Int!
    
    @IBOutlet var background_view: UIView!
    @IBOutlet weak var message_view: UIView!
    @IBOutlet weak var purchases_collection_view: UICollectionView!
    @IBOutlet weak var done_btn: UIButton!
    @IBOutlet weak var category_name: UILabel!
    @IBOutlet weak var switch_layout_button: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_add_purchase" {
            let add_purchase = segue.destination as! AddPurchaseVC
            add_purchase.expenses_vc = self
            add_purchase.category = category
            add_purchase.category_index = category_index
        }
    }
    
    override func viewDidLoad() {
        done_btn.roundCorners(7.5)
        done_btn.layer.borderWidth = 1.5
        done_btn.layer.borderColor = Canvas.watermelon_red.cgColor
        background_view.layer.backgroundColor = Canvas.super_light_gray.cgColor
        
        category_name.text = category.name
        
        formatCells()
        initializeCollectionView()
        //initializePurchases()
    }
    
    // TODO: testing
    func initializePurchases() {
        categories_vc.categories[category_index].purchases.append(Purchase(name: "Plane ticket", cost: 340.40, date: "8/07/18", info: "JetBlue", id: 0))
        categories_vc.categories[category_index].purchases.append(Purchase(name: "Dinner", cost: 340.40, date: "8/07/18", info: "JetBlue", id: 0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initializeCollectionView() {
        // set the delegate and datasource to ExpensesVC
        purchases_collection_view.delegate = self
        purchases_collection_view.dataSource = self
        
        purchases_collection_view.layer.backgroundColor = Canvas.super_light_gray.cgColor
        
        // add the custom collection view cells to this collection view
        purchases_collection_view.register(UINib(nibName: "PurchaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PurchaseCollectionViewCell.reuse_id)
        purchases_collection_view.register(UINib(nibName: "AddPurchaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AddPurchaseCollectionViewCell.reuse_id)
        
        purchases_collection_view.reloadData()
    }
    
    func formatCells() {
        let layout = self.purchases_collection_view.collectionViewLayout as! UICollectionViewFlowLayout

        // create spacing between cells
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5

        // splits each row between three cells
        layout.itemSize = CGSize(width: (self.purchases_collection_view.frame.size.width - 20) / 4, height: self.purchases_collection_view.frame.size.height / 3)
    }
    
    // MARK: collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 140, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let vert_space : CGFloat = 10
        
        //Calculate horizontal spacing:
        //    Total view width - combined padding - total cell width
        //let num_cells = purchases_collection_view.numberOfItems(inSection: 0)
        var hor_space : CGFloat = 0
        if hor_space < 5 { hor_space = 40 }
        
        return UIEdgeInsets(top: vert_space, left: hor_space, bottom: vert_space, right: hor_space)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // add an additional cell to be the add purchase cell
        return categories_vc.categories[category_index].purchases.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // base case: no purchases
        if categories_vc.categories[category_index].purchases.count == 0 {
            let add_cell = purchases_collection_view.dequeueReusableCell(withReuseIdentifier: AddPurchaseCollectionViewCell.reuse_id, for: indexPath) as! AddPurchaseCollectionViewCell
        
            add_cell.initialize(parent: self)
            return add_cell
        }
    
        // store the index of this cell in the array
        let index = indexPath.row

        // use a purchase collection view cell
        // FIXME: not using the modified copy--how to make this less error-prone? How to modify the parent's member variables by reference
        if index < categories_vc.categories[category_index].purchases.count {
            let purchase_cell = purchases_collection_view.dequeueReusableCell(withReuseIdentifier: PurchaseCollectionViewCell.reuse_id, for: indexPath) as! PurchaseCollectionViewCell

            purchase_cell.initialize(category: categories_vc.categories[category_index], parent: self, purchase_id: index)

            return purchase_cell
        } else { // always include an add purchase cell
            let add_cell = purchases_collection_view.dequeueReusableCell(withReuseIdentifier: AddPurchaseCollectionViewCell.reuse_id, for: indexPath) as! AddPurchaseCollectionViewCell
            
            add_cell.initialize(parent: self)

            return add_cell
        }
    }
    
    func addNewPurchase(_ purchase: Purchase, _ category_index : Int) {
        categories_vc.categories[category_index].purchases.append(purchase)
        
        // Animate adding a new cell
        purchases_collection_view.performBatchUpdates({
            self.purchases_collection_view.reloadSections(IndexSet(integer: 0))
        }, completion: nil)
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
