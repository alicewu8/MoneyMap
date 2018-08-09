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
    
    var expenses_vc : ExpensesVC!
    var category : Category!
    var purchase : Purchase!
    var category_index : Int!
    
    private var date_picker : UIDatePicker?
    
    var initial_touch_point : CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        setUpUI()
        configureTextFields()
        configureTapGesture()
        configureDatePicker()
        
        // add a pan gesture recognizer to support swiping the screen to dismiss
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panScreen(_:)))
        view.addGestureRecognizer(pan)
    }
    
    // vertically displaces this screen and handles swipe to dismiss
    @objc func panScreen(_ sender: UIPanGestureRecognizer) {
        // stores the origin of the pan gesture
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizer.State.began {
            initial_touch_point = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            // only move the screen with a down swipe
            if touchPoint.y - initial_touch_point.y > 0 {
                // displace by the vertical delta between the new touch and the initial
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initial_touch_point.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            // dismiss the screen if it is dragged by more than 100 pixels
            if touchPoint.y - initial_touch_point.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // revert its position to the top
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
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
    
    // displays the purchase info in the text field
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
        purchase = Purchase(name: "", cost: 0, date: "", info: "", id: 0)
        // check for nil values
        // convert string to Double: NSString has a built in way to convert
        // check for whether the optional values exist and assign them
        if let cost = purchase_cost.text, let name = purchase_name.text, let date = purchase_date.text, let additional_info = additional_info.text {
            purchase.cost = (cost as NSString).doubleValue
            purchase.name = name
            purchase.date = date
            purchase.info = additional_info
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
