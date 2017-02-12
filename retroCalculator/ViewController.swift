//
//  ViewController.swift
//  retroCalculator
//
//  Created by Konstantinas Falkovskis on 11/02/2017.
//  Copyright © 2017 Falco. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
    
    case devide = "/"
    case multiply = "x"
    case minus = "-"
    case plus = "+"
    case empty = "Empty"
        
    }
 
    
    @IBOutlet weak var label: UILabel!
    
    var btSound: AVAudioPlayer!
    
    var putNumbers = ""
    var leftSide = ""
    var rightSide = ""
    var result = ""
    var currOperation: Operation = Operation.empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource:"btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
       
        do {
            try btSound = AVAudioPlayer(contentsOf: soundUrl as URL)
            btSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
 
    @IBAction func numberPressedWithBt(bt: UIButton!){
        playSound()
        
        putNumbers += "\(bt.tag)"
        label.text = putNumbers
    }
    
    @IBAction func onDevide(_ sender: UIButton) {
        processOperation(pr: Operation.devide)
    }
    
   
    @IBAction func onMultiply(_ sender: UIButton) {
        processOperation(pr: Operation.multiply)
    }
    
    @IBAction func onMinus(_ sender: UIButton) {
        processOperation(pr: Operation.minus)
    }
   
    @IBAction func onPlus(_ sender: UIButton) {
        processOperation(pr: Operation.plus)
    }
    
    @IBAction func onEqual(_ sender: UIButton) {
        processOperation(pr: currOperation)
    }
    
    func processOperation(pr: Operation) {
        playSound()
        
        if currOperation != Operation.empty {
            if putNumbers != "" {
                rightSide = putNumbers
                putNumbers = ""
                
                if currOperation == Operation.devide {
                    result = "\(Double(leftSide)! / Double(rightSide)!)"
                } else if currOperation == Operation.multiply {
                    result = "\(Double(leftSide)! * Double(rightSide)!)"
                } else if currOperation == Operation.minus {
                    result = "\(Double(leftSide)! - Double(rightSide)!)"
                } else if currOperation == Operation.plus {
                    result = "\(Double(leftSide)! + Double(rightSide)!)"
                }
                leftSide = result
                label.text = result
            }
            
            currOperation = pr
            
        } else {
            leftSide = putNumbers
            putNumbers  = ""
            currOperation = pr
        }
    }
    
    func playSound() {
        if btSound.isPlaying {
            btSound.stop()
        }
        btSound.play()
    }
    
}

