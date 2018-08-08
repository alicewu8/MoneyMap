//
//  ExpensesListViewController.swift
//  money-mapp
//
//  Created by Alice Wu on 8/7/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class ExpensesListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var purchases_table_view: UITableView!
    
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
        
        purchases_table_view.layer.backgroundColor = Canvas.super_light_gray.cgColor
        
        purchases_table_view.delegate = self
        purchases_table_view.dataSource = self
        
        purchases_table_view.register(UINib(nibName: "PurchaseTableViewCell", bundle: nil), forCellReuseIdentifier: PurchaseTableViewCell.reuse_id)
        purchases_table_view.register(UINib(nibName: "AddPurchaseTableViewCell", bundle: nil), forCellReuseIdentifier: AddPurchaseTableViewCell.reuse_id)
    }
    
    // number of purchases + 1 to represent the add purchase cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parent.categories_vc.categories[category_index].purchases.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // base case: no purchases
        if parent.categories_vc.categories[category_index].purchases.count == 0 {
            let add_cell = purchases_table_view.dequeueReusableCell(withIdentifier: AddPurchaseTableViewCell.reuse_id, for: indexPath) as! AddPurchaseTableViewCell
            
            //add_cell.initialize(parent: parent)
            return add_cell
        }
        
        // store the index of the current cell: represents the purchase in its array
        let index = indexPath.row
        
        if index < parent.categories_vc.categories[category_index].purchases.count {
            let purchase_cell = purchases_table_view.dequeueReusableCell(withIdentifier: PurchaseTableViewCell.reuse_id, for: indexPath) as! PurchaseTableViewCell
            
            //purchase_cell.initialize(parent: parent)
            
            return purchase_cell
        } else {
            let add_cell = purchases_table_view.dequeueReusableCell(withIdentifier: AddPurchaseTableViewCell.reuse_id, for: indexPath) as! AddPurchaseTableViewCell
            
            //add_cell.initialize(parent: parent)
            return add_cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("Todo")
        return 40
    }
    
}
