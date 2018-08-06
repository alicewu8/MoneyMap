//
//  AddPurchaseVC.swift
//  money-mapp
//
//  Created by Alice Wu on 8/5/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import Foundation
import UIKit

class AddPurchaseVC : UIViewController {
    
    var expenses_vc : ExpensesVC!
    var category : Category!
    var purchase : Purchase!
    var category_index : Int!
    
    @IBOutlet weak var remove_button: UIButton!
    @IBOutlet weak var done_button: UIButton!
    
    @IBOutlet weak var recording_stack_view: UIStackView!
    @IBOutlet weak var purchase_name: UITextField!
    @IBOutlet weak var purchase_cost: UITextField!
    @IBOutlet weak var purchase_date: UITextField!
    @IBOutlet weak var additional_info: UITextField!
    
    override func viewDidLoad() {
        setUpUI()
        
        // TODO: placeholder for testing. Instantiate a purchase (do this in the segue! Need to pass correct id info)
        purchase = Purchase(name: "", cost: 0, date_of_purchase: "", additional_info: "", id: 0)
    }
    
    private func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddBudgetVC.tapHandler))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapHandler() {
        view.endEditing(true)
    }
    
    private func configureTextFields() {
        purchase_name.delegate = self
        purchase_cost.delegate = self
        purchase_date.delegate = self
        additional_info.delegate = self
    }
    
    func setUpUI() {
        remove_button.roundCorners(7.5)
        done_button.roundCorners(7.5)
        remove_button.layer.borderWidth = 2
        remove_button.layer.borderColor = Canvas.artificial_watermelon.cgColor
        done_button.layer.borderWidth = 2
        done_button.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func doneEditing(_ sender: Any) {
        // check for nil values
        guard let cost = purchase_cost.text else {
            // TODO: prompt user to enter a cost and don't let the screen dismiss
            return
        }
        //purchase.cost = Double(cost)!  
        // check for whether the optional values exist and assign them
        if let name = purchase_name.text, let date = purchase_date.text, let additional_info = additional_info.text {
            purchase.name = name
            purchase.date_of_purchase = date
            purchase.additional_info = additional_info
        }
        
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
        print(purchase)
        expenses_vc.addNewPurchase(purchase, category_index)
    }
    
    /* TODO: check if this purchase already exists in the array
     if it does, remove it by its id
    */
    @IBAction func removePurchase(_ sender: Any) {
        print("Implement!")
    }
}

// This view controller is a delegate for UITextField
extension AddPurchaseVC: UITextFieldDelegate {
    
    // dismisses keyboard after return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
