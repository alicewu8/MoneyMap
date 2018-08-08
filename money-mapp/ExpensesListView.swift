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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
}
