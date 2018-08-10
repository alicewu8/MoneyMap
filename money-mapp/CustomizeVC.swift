//
//  CustomizeVC.swift
//  money-mapp
//
//  Created by Alice Wu on 8/10/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import Foundation
import UIKit

class CustomizeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var customize_view: UIView!
    @IBOutlet weak var colors_collection_view: UICollectionView!
    @IBOutlet weak var title_view: UIView!
    
    @IBOutlet weak var options_table_view: UITableView!
    
    struct Customization {
        var name : String
        var image : UIImage
        var selected : Bool
    }

    var options : [Customization] = []

    var colors : [CGColor] = []
    
    var selected_color_index : Int!
    
    var categories_vc : CategoriesVC!
    
    override func viewDidLoad() {
        initializeOptions()
        initializeColors()
        
        colors_collection_view.delegate = self
        colors_collection_view.dataSource = self
        
        options_table_view.delegate = self
        options_table_view.dataSource = self
        
        options_table_view.register(UINib(nibName: "CustomizeTableViewCell", bundle: nil), forCellReuseIdentifier: CustomizeTableViewCell.reuse_id)
    }

    func initializeOptions() {
        options.append(Customization(name: "Rename", image: UIImage(named: "edit")!, selected: false))
        options.append(Customization(name: "Change Colors", image: UIImage(named: "palette")!, selected: false))
        options.append(Customization(name: "Edit Budget", image: UIImage(named: "money_unlock")!, selected: false))
    }
    
    func initializeColors() {
        colors.append(Canvas.cheerful_green.cgColor)
        colors.append(Canvas.first_date.cgColor)
        colors.append(Canvas.shy_moment.cgColor)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeTableViewCell", for: indexPath) as! CustomizeTableViewCell
        
        cell.parent = self
        
        cell.initialize(index)
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "color_cell", for: indexPath) as! ColorCell
        
        cell.index_path = indexPath
        cell.parent = self
        
        cell.initialize(index)
        
        return cell
    }
}
