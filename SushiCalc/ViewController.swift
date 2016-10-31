//
//  ViewController.swift
//  SushiCalc
//
//  Created by Kyle Sargent on 10/29/16.
//  Copyright © 2016 Kyle Sargent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*
     TODO: Put price fields in an array
     TODO: Fix calc to run through each counter and price
     TODO: Refactor variables to increase readibility
     
     TODO: Create secondary page that allows the changing of plate colors
     */
    
    @IBOutlet var plateCounters: [UILabel]!
    
    @IBOutlet weak var plate0Price: UITextField!
    @IBOutlet weak var plate1Price: UITextField!
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
        let count = Int(plateCounters[0].text!)!
        
        if count <= 0 {
            plateCounters[tag].text = String(0)
        } else {
            plateCounters[tag].text = String(count - 1)
        }
        calc()
    }
    
    func calc() {
        let x = Double(plateCounters[0].text!)!

        
        let p: Double! = Double(plate0Price.text!)!
        totalPrice.text = String(format: "$%.2f", x * p)
        taxedTotalPrice.text = String(format: "$%.2f", x * p * 1.095)
        tippedTotalPrice.text = String(format: "$%.2f", x * p * 1.095 * 1.18)
    }
    

}

