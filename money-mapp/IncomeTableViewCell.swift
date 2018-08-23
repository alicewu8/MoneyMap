//
//  IncomeTableViewCell.swift
//  money-mapp
//
//  Created by Alice Wu on 8/23/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

class IncomeTableViewCell: UITableViewCell {

    static let reuse_id = "IncomeCell"
    
    @IBOutlet weak var income_image: UIImageView!
    @IBOutlet weak var income_name: UILabel!
    @IBOutlet weak var income_amt: UILabel!
    
    var parent : CategoriesVC!
    var index : Int!
    var income : Income!
    
    func initialize(_ parent: CategoriesVC, _ index: Int) {
        self.parent = parent
        self.index = index
        self.income = parent.income[index]
        
        self.roundCorners(9)
        
        // don't round these corners
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        self.layer.backgroundColor = Canvas.peach.cgColor
        
        // change the alpha from 0.5 to 1.0
        let color = UIColor(cgColor: self.layer.backgroundColor!)
        
        if index % 2 == 0 {
            self.layer.backgroundColor = color.withAlphaComponent(0.6).cgColor
        }
        
        // set the cell information
        income_name.text = income.name
        income_amt.text = String(format: "%.2f", income.amount)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
