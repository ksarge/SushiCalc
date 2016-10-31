//
//  ViewController.swift
//  SushiCalc
//
//  Created by Kyle Sargent on 10/29/16.
//  Copyright © 2016 Kyle Sargent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    @IBOutlet weak var plate0Count: UILabel!
//    @IBOutlet weak var plate1Count: UILabel!

    @IBOutlet var plateCounters: [UILabel]!
    
    
    @IBOutlet weak var plate0Price: UITextField!
    @IBOutlet weak var plate1Price: UITextField!
    

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var taxedTotalPrice: UILabel!
    @IBOutlet weak var tippedTotalPrice: UILabel!
    
    
    /* TODO: Find out a way to make different buttons utilize the same callbacks and then update the corresponding plateCount.
     */
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        
        let x = Int(plateCounters[0].text!)!
        
        plateCounters[0].text = String(x + 1)
        
        calc()
    }

    @IBAction func subButtonPressed(_ sender: UIButton) {
        
        let x = Int(plateCounters[0].text!)!
        
        if x <= 0 {
            plateCounters[0].text = String(0)
        } else {
            plateCounters[0].text = String(x - 1)
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

