//
//  ViewController.swift
//  MyCalculator
//
//  Created by Muhammadjon Loves on 7/21/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var player: AVAudioPlayer?
    
    private var isFinishedTyping = true
        
    private var displayValue: Double {
        get {
            let number = Double(displayLabel.text!) ?? 0
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        playSound()
        pressEffect(sender)
                        
        isFinishedTyping = true
        calculator.setNumber(displayValue)
                
        if let calcMethod = sender.titleLabel?.text {
            if let result = calculator.calculate(symbol: calcMethod, displayLbl: &(displayLabel.text!)) {
                displayValue = result
            }
        }
    }
    

    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        playSound()
        pressEffect(sender)
        
        if let numValue = sender.titleLabel?.text {
            if isFinishedTyping {
                displayLabel.text = numValue
                isFinishedTyping = false
            } else {
                if numValue == "." {
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }
    
    //MARK: - Press Effect and Sound
    
    func pressEffect(_ sender: UIButton) {
        // Pressing Button effect
        sender.alpha = 0.6
        // It's gonna delay                             0.1 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // And change it back to 100%
            sender.alpha = 1
        }
    }
    
    func playSound() {
        
        guard let path = Bundle.main.path(forResource: "Button", ofType:"wav") else {
            print("Didnt work")
            return
        }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

