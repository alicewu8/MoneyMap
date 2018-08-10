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
    
    @IBOutlet var customize_outer: UIView!
    @IBOutlet weak var customize_view: UIView!
    @IBOutlet weak var colors_collection_view: UICollectionView!
    @IBOutlet weak var title_view: UIView!
    
    @IBOutlet weak var options_table_view: UITableView!
    
    struct Customization {
        var name : String
        var image : UIImage?
        var selected : Bool?
    }

    var options : [Customization] = []

    var colors : [CGColor] = []
    
    // records the color chosen by the user
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
        
        options_table_view.register(UINib(nibName: "BlankTableViewCell", bundle: nil), forCellReuseIdentifier: "blank_cell")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(screenTapped(_:)))
        customize_outer.addGestureRecognizer(tap)
    }

    func initializeOptions() {
        options.append(Customization(name: "Rename", image: UIImage(named: "edit")!, selected: false))
        options.append(Customization(name: "", image: nil, selected: nil))
        options.append(Customization(name: "Change Colors", image: UIImage(named: "palette")!, selected: false))
        options.append(Customization(name: "", image: nil, selected: nil))
        options.append(Customization(name: "Edit Budget", image: UIImage(named: "money_unlock")!, selected: false))
    }
    
    func initializeColors() {
        colors.append(Canvas.cheerful_green.cgColor)
        colors.append(Canvas.first_date.cgColor)
        colors.append(Canvas.shy_moment.cgColor)
        colors.append(Canvas.electric_blue.cgColor)
        colors.append(Canvas.flamingo.cgColor)
        colors.append(Canvas.grapefruit.cgColor)
        colors.append(Canvas.purple_mountain_majesty.cgColor)
        colors.append(Canvas.watermelon_red.cgColor)
        colors.append(Canvas.summertime.cgColor)
    }
    
    @objc func screenTapped(_ sender: UITapGestureRecognizer) {
        colorsPopAway()
    }
    
    // TODO: pop up/bounce animation for the color picker
    func colorsPopUp() {
        customize_view.center = CGPoint(x: options_table_view.frame.width / 2, y: options_table_view.frame.height / 2)
        
        self.view.addSubview(customize_outer)
        
        customize_outer.frame.size = view.frame.size
        customize_outer.frame.origin.x = 0
        customize_outer.frame.origin.y = 0
        
        customize_outer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        customize_view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        customize_view.roundCorners()
        
        customize_view.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.customize_outer.alpha = 1
            self.customize_view.alpha = 1
            
            // restore its previous size
            self.customize_view.transform = CGAffineTransform.identity
            self.customize_outer.transform = CGAffineTransform.identity
        }
    }
    
    func colorsPopAway() {
        UIView.animate(withDuration: 0.3, animations: {
            self.customize_outer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.customize_outer.alpha = 0
            
        }) { (success: Bool) in
            self.customize_outer.transform = CGAffineTransform.identity
            self.customize_outer.removeFromSuperview()
        } // completion block: executes after animation block has run
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        if index % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeTableViewCell", for: indexPath) as! CustomizeTableViewCell
            
            cell.parent = self
            
            cell.initialize(index)
            
            return cell
        } else {
            let blank_cell = tableView.dequeueReusableCell(withIdentifier: "blank_cell", for: indexPath) as! BlankTableViewCell
            
            blank_cell.initialize()
            
            return blank_cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 75
        } else {
            return 25
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        switch index {
        case 0:
            print("Rename this category")
            
        case 2:
            print("Choose color")
            colorsPopUp()
            
        case 4:
            print("Edit budget")
            
        default:
            print("tap!")
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            // expand the cell
            self.colors_collection_view.cellForItem(at: indexPath)?.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }) { (success: Bool) in
            self.colors_collection_view.cellForItem(at: indexPath)?.transform = CGAffineTransform.identity
        }
        
        print(selected_color_index)
    }
    
    @IBAction func returnToPrevious(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
