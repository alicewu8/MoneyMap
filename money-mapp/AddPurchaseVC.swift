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
    
    private var date_picker : UIDatePicker?
    
    @IBOutlet weak var return_button: UIButton!
    @IBOutlet weak var done_button: UIButton!
    @IBOutlet weak var review_button: UIButton!
    
    @IBOutlet weak var purchase_name: UITextField!
    @IBOutlet weak var purchase_cost: UITextField!
    @IBOutlet weak var purchase_date: UITextField!
    @IBOutlet weak var additional_info: UITextField!
    @IBOutlet weak var edit_view: UIView!
    @IBOutlet weak var display_purchase_info: UITextView!
    
    @IBOutlet weak var separator_one: UIView!
    @IBOutlet weak var separator_two: UIView!
    @IBOutlet weak var separator_three: UIView!
    
    override func viewDidLoad() {
        setUpUI()
        configureTextFields()
        configureTapGesture()
        configureDatePicker()
    }
    
    // TODO: add min/max dates
    // TODO: only dismiss if month, day, and year are all confirmed
    private func configureDatePicker() {
        date_picker = UIDatePicker()
        date_picker?.datePickerMode = .date
        date_picker?.addTarget(self, action: #selector(AddPurchaseVC.dateChanged(date_picker:)), for: .valueChanged)
        
        //date_picker?.maximumDate = Date(timeIntervalSince1970: <#T##TimeInterval#>)
        
        // the date picker will be displayed inside purchase_date
        purchase_date.inputView = date_picker
    }
    
    @objc func dateChanged(date_picker: UIDatePicker) {
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "MM/dd/yyyy"
        purchase_date.text = date_formatter.string(from: date_picker.date)
        view.endEditing(true)
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
        edit_view.roundCorners()
        done_button.roundCorners(7.5)
        separator_one.roundCorners()
        separator_two.roundCorners()
        separator_three.roundCorners()
        
        display_purchase_info.roundCorners(9)
        review_button.roundCorners()
//        review_button.layer.borderColor = Canvas.french_sky_blue.cgColor
//        review_button.titleLabel?.textColor = Canvas.french_sky_blue
    }
    
    @IBAction func returnToPrevious(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reviewDetails(_ sender: Any) {
        // display info in the text view
        // FIXME: check for nil values
        display_purchase_info.text = """
        \(purchase_name.text!)
        \(purchase_cost.text!)
        \(purchase_date.text!)
        \(additional_info.text!)
        """
        print(display_purchase_info.text)
    }
    
    @IBAction func doneEditing(_ sender: Any) {
        
        // TODO: placeholder for testing. Instantiate a purchase (do this in the segue! Need to pass correct id info)
        purchase = Purchase(name: "", cost: 0, date_of_purchase: "", additional_info: "", id: 0)
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
}


// This view controller is a delegate for UITextField
extension AddPurchaseVC: UITextFieldDelegate {
    
    // dismisses keyboard after return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}