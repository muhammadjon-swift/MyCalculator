//
//  CalculatorLogic.swift
//  MyCalculator
//
//  Created by Muhammadjon Loves on 7/22/22.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Double?
    
    private var intermidiateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculate(symbol: String, displayLbl: inout String) -> Double? {
        
        if let n = number {
            
            switch symbol {
            case "+/-":
                return n * -1
            case "C":
                return 0
            case "%":
                return n / 100
            case "d":
                if displayLbl.isEmpty == true {
                    
                } else {
                    displayLbl.removeLast()
                }
            case "=":
               return performTwoNumCalculation(n2: n)
            default:
                intermidiateCalculation = (n1: n, calcMethod: symbol)
            }
        }
        return nil
    }
    
    func performTwoNumCalculation(n2: Double) -> Double? {
        
        if let n1 = intermidiateCalculation?.n1, let operation = intermidiateCalculation?.calcMethod {
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "/":
                return n1 / n2
            case "x":
                return n1 * n2
            default:
                fatalError("Tings went really wrong bruv")
            }
        }
        return nil
    }
}
