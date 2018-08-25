//
//  AddBudgetVC.swift
//  money-mapp
//
//  Created by Alice Wu on 8/4/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import Foundation
import UIKit

class AddBudgetVC : UIViewController {
    
    var categories_vc : CategoriesVC!
    var category_cell : CategoryCollectionViewCell!
    var category_index : Int!
    
    @IBOutlet weak var add_budget_btn: UIButton!
    @IBOutlet weak var budget_text_field: UITextField!
    @IBOutlet weak var budget_prompt: UILabel!
    @IBOutlet weak var add_budget_view: UIView!
    
    override func viewDidLoad() {
        formatViews()
    }
    
    func formatViews() {
        // modify UI elements
        add_budget_view.roundCorners(7.5)
        add_budget_btn.roundCorners(7.5)
    }
    
    private func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddBudgetVC.tapHandler))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapHandler() {
        view.endEditing(true)
    }
    
    // Configure delegates for text fields
    private func configureTextFields() {
        budget_text_field.delegate = self
    }
    
    @IBAction func doneEditingText(_ sender: Any) {
        // set the user_entered budget as the button's updated label
        category_cell.budget_button.setTitle(budget_text_field.text, for: .normal)
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        // convert from string to int and add the budget to the given category
        // pass the category id
        guard let user_budget = Double(budget_text_field.text!) else { return }
        print(category_cell.category)
        categories_vc.updateBudget(category_index, user_budget)
    }
    
    // returns to categoriesVC as main view
    @IBAction func doneAddingBudget(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// This view controller is a delegate for UITextField
extension AddBudgetVC: UITextFieldDelegate {
    
    // dismisses keyboard after return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        budget_text_field.resignFirstResponder()
        return true
    }
}
