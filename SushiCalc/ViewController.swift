//
//  ViewController.swift
//  SushiCalc
//
//  Created by Kyle Sargent on 10/29/16.
//  Copyright © 2016 Kyle Sargent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.text = String(format: "$%.2f", textField)
    }
    
    /*
     TODO: Create secondary page that allows the changing of plate colors
     */
    
    @IBOutlet var plateCounters: [UILabel]!
    @IBOutlet var platePrices: [UITextField]!
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var taxedTotalPrice: UILabel!
    @IBOutlet weak var tippedTotalPrice: UILabel!
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let tag   = sender.tag
        let count = Int(plateCounters[tag].text!)!
        plateCounters[tag].text = String(count + 1)
        calc()
    }

    @IBAction func subButtonPressed(_ sender: UIButton) {
        let tag   = sender.tag
        let count = Int(plateCounters[tag].text!)!
        
        if count <= 0 {
            plateCounters[tag].text = String(0)
        } else {
            plateCounters[tag].text = String(count - 1)
        }
        calc()
    }
    
    func calc() {
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

