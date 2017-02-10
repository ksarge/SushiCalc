//
//  ViewController.swift
//  SushiCalc
//
//  Created by Kyle Sargent on 10/29/16.
//  Copyright © 2016 Kyle Sargent. All rights reserved.
//

/*
 TODO: Create secondary page that allows the changing of plate colors
 TODO: Fix keyboard
 http://stackoverflow.com/questions/31363216/set-the-maximum-character-length-of-a-uitextfield-in-swift
 TODO: Add done button to num pad
 http://stackoverflow.com/questions/28338981/how-to-add-done-button-to-numpad-in-ios-8-using-swift
 TODO: Support scrolling 
 http://www.appcoda.com/uiscrollview-introduction/
 http://stackoverflow.com/questions/1126726/how-to-make-a-uitextfield-move-up-when-keyboard-is-present
 */


import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var platePrices: [UITextField]!
    @IBOutlet var plateCounters: [UILabel]!
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var taxedTotalPrice: UILabel!
    @IBOutlet weak var tippedTotalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
    }

    
    /* Touching the screen anywhere closes the keyboard */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /* Formats text fields to be of format %_.__ */
    func textFieldDidEndEditing(_ textField: UITextField) {
        let entry: Double? = Double(textField.text!)
        if entry != nil {
            textField.text = String(format: "%.2f", entry!)
        } else {
            textField.text = String(format: "%.2f", Double(textField.tag) + 1)
        }
    }
    
    /* Reset button pressed */
    @IBAction func resetButtonPressed(_ sender: Any) {
        let len = plateCounters.count
        for i in 0..<len {
            plateCounters[i].text = "0"
            platePrices[i].resignFirstResponder()

        }
        calculateTotals()
    }
    
    /* Add button action */
    @IBAction func addButtonPressed(_ sender: UIButton) {
        for i in 0..<platePrices.count {
            self.platePrices[i].resignFirstResponder()
        }
        let tag   = sender.tag
        let count = Int(plateCounters[tag].text!)!
        plateCounters[tag].text = String(count + 1)
        calculateTotals()
    }
    
    /* Subtract button action */
    @IBAction func subButtonPressed(_ sender: UIButton) {
        for i in 0..<platePrices.count {
            self.platePrices[i].resignFirstResponder()
        }
        let tag   = sender.tag
        let count = Int(plateCounters[tag].text!)!
        if count <= 0 {
            plateCounters[tag].text = String(0)
        } else {
            plateCounters[tag].text = String(count - 1)
        }
        
        calculateTotals()
    }
    
    /* Calculates subtotal, tax, and tip */
    func calculateTotals() {
        let len = plateCounters.count
        
        var total = 0.00
        
        for i in 0..<len {
            let count = Double(plateCounters[i].text!)!
            let price = Double(platePrices[i].text!)!
            total += count * price
        }
        totalPrice.text = String(format: "$%.2f", total)
        taxedTotalPrice.text = String(format: "$%.2f", total * 1.095)
        tippedTotalPrice.text = String(format: "$%.2f", total * 1.095 * 1.18)
    }
}

extension UIViewController {
    func keyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

