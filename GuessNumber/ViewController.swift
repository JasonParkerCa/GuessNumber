//
//  ViewController.swift
//  EveryDay
//
//  Created by Jason Parker on 2018-01-16.
//  Copyright © 2018 Jason Parker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var targetLabel:UILabel!
    @IBOutlet weak var scoreLabel:UILabel!
    @IBOutlet weak var roundLabel:UILabel!
    
    var currentValue:Int = 0
    var targetValue:Int = 0
    var currentRound:Int = 0
    var currentScore:Int = 0
    var alertTitle:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startOver()
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue=50
        slider.value = Float(currentValue)
        updateLabels()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert(){
        if abs(targetValue-Int(lroundf(slider.value))) == 0 {
            alertTitle="Congratulations!"
        } else if abs(targetValue-Int(slider.value))>0 && abs(targetValue-Int(slider.value))<=5 {
            alertTitle="Almost!"
        } else {
            alertTitle="Sorry..."
        }
        let message = "The current actual value: \(currentValue)   \nThe target value is: \(targetValue)"
        let alert = UIAlertController(title:alertTitle,message:message,preferredStyle: .alert)
        let action = UIAlertAction(title:"OK",style: .default,handler: nil)
        alert.addAction(action)
        present(alert,animated:true,completion:nil)
        startNewRound()
        updateLabels()
    }
    
    @IBAction func sliderMoved(slider: UISlider){
        //print("The actual value of the slide: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound(){
        currentRound = currentRound+1
        currentScore=currentScore+100-abs(targetValue-Int(lroundf(slider.value)))
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue=50
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = String (targetValue)
        scoreLabel.text = String(currentScore)
        roundLabel.text = String(currentRound)
    }
    
    @IBAction func startOver() {
        currentRound=0
        currentScore=0
        scoreLabel.text = String(currentScore)
        roundLabel.text = String(currentRound)
        currentValue=50
        slider.value = Float(currentValue)
    }
    
}
