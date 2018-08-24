//
//  IncomeTableView.swift
//  money-mapp
//
//  Created by Alice Wu on 8/23/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import Foundation
import UIKit

class IncomeTableView : UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var income_list: UITableView!
    
    var parent: CategoriesVC!
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // as many cells as there are recorded income items
        return parent.income.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let index = indexPath.row
        
        let income_cell = income_list.dequeueReusableCell(withIdentifier: IncomeTableViewCell.reuse_id, for: indexPath) as! IncomeTableViewCell
        
        income_cell.initialize(parent, index)
        
        return income_cell
    }
    
    func initialize(_ parent: CategoriesVC) {
        self.parent = parent
        
        income_list.layer.backgroundColor = Canvas.super_light_gray.cgColor
        
        income_list.delegate = self
        income_list.dataSource = self
        
        income_list.register(UINib(nibName: "IncomeTableViewCell", bundle: nil), forCellReuseIdentifier: IncomeTableViewCell.reuse_id)
    }
    
    func refreshInfo() {
        UIView.transition(with: self.income_list, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.income_list.reloadData()
        }, completion: nil)
    }
}
