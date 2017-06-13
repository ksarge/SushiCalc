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
    
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    var calc = Calculator(6)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
    }
    
    //TODO: RESIGN THOSE FIRST RESPONDERS
    
    /* Touching the screen anywhere closes the keyboard */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /* Formats text fields to be of format %_.__ */
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.text = "0.00"
        }
        calc.setPlatePrice(Double(textField.text!)!, textField.tag)
        platePrices[textField.tag].text = String(calc.getPlatePrice(textField.tag))
        calc.calculateTotal()
        refreshTotals()

        
    }
    
    /* Reset button pressed */
    @IBAction func resetButtonPressed(_ sender: Any) {
        calc.reset()
        calc.calculateTotal()
        refreshTotals()
        refreshCounters()
    }
    
    @IBAction func sliderUpdated(_ sender: UISlider) {
        calc.setTip(Int(sender.value))
        let tip = Int(calc.getTip() * 100)
        tipLabel.text = String(format: "with %d%% tip:", tip)
        calc.calculateTotal()
        refreshTotals()
    }
    
    /* Add button action */
    @IBAction func addButtonPressed(_ sender: UIButton) {
        for i in 0..<platePrices.count {
            self.platePrices[i].resignFirstResponder()
        }
        
        let tag = sender.tag
        
        calc.incrementCounter(tag)
        
        // Update label
        plateCounters[tag].text = String(calc.getPlateCounter(tag))
        
        calc.calculateTotal()
        refreshTotals()
    }
    
    
    /* Subtract button action */
    @IBAction func subButtonPressed(_ sender: UIButton) {
        for i in 0..<platePrices.count {
            self.platePrices[i].resignFirstResponder()
        }
        let tag = sender.tag
        
        calc.decrementCounter(tag)
        
        // Update label
        plateCounters[tag].text = String(calc.getPlateCounter(tag))
        
        calc.calculateTotal()
        refreshTotals()

    }
    
    /* Calculates subtotal, tax, and tip */
    func refreshTotals() {
        totalPrice.text = String(format: "$%.2f", calc.total)
        taxedTotalPrice.text = String(format: "$%.2f", calc.total * 1.095)
        tippedTotalPrice.text = String(format: "$%.2f", calc.total * 1.095 * (1.0 + calc.tip))
    }
    
    func refreshCounters() {
        for i in 0..<plateCounters.count {
            plateCounters[i].text = String(calc.getPlateCounter(i))
        }
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

