//
//  Calculator.swift
//  SushiCalc
//
//  Created by Kyle Sargent on 6/8/17.
//  Copyright © 2017 Kyle Sargent. All rights reserved.
//

import Foundation

class Calculator {
    var numPlates = 0
    var platePrices = [Double]()
    var plateCounters = [Int]()
    
    var total = 0.00
    var tip = 0.15
    
    init(_ plateCount : Int) {
        for i in 0..<plateCount {
            platePrices.append(Double(i + 1))
            plateCounters.append(0)
        }
    }
    
    func setTip(_ newTip : Int) {
        tip = Double(newTip) / 100
    }
    
    func getTip() -> Double{
        return tip
    }
    
    func setPlatePrice(_ price : Double, _ tag : Int) {
        if platePrices.count > tag {
            platePrices[tag] = format(price)
        }
    }
    
    func getPlatePrice(_ tag : Int) -> Double {
        if platePrices.count > tag {
            return platePrices[tag]
        }
        return -1
    }
    
    func getPlateCounter(_ tag : Int) -> Int {
        if plateCounters.count > tag {
            return plateCounters[tag]
        }
        
        return -1
    }
    
    
 
    
    func format(_ num : Double) -> Double{
        return Double(String(format: "%.02f", num))!
    }
    
    func format(_ str : String) -> String {
        return String(format: "$%.02s", str)
    }
    
    
    func reset() {
        total = 0.00
        for i in 0..<plateCounters.count {
            plateCounters[i] = 0
        }
    }
    
    func calculateTotal(){
        total = 0.00
        for i in 0..<platePrices.count {
            total += platePrices[i] * Double(plateCounters[i])
        }
        total = format(total)
    }
    
    func incrementCounter(_ tag : Int) {
        if plateCounters.count > tag {
            plateCounters[tag] += 1
        }
    }
    
    func decrementCounter(_ tag : Int) {
        if plateCounters.count > tag {
            if plateCounters[tag] > 0 {
                plateCounters[tag] -= 1
            }
        }
    }
}
