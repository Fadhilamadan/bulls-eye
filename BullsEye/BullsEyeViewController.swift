//
//  BullsEyeViewController.swift
//  BullsEye
//
//  Created by Fadhil Amadan on 7/1/20.
//  Copyright © 2020 Fadhil Amadan. All rights reserved.
//

import UIKit

class BullsEyeViewController: UIViewController {
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var readyButtonOutlet: UIButton!
    
    var randomNumber: Double = 0.0
    var isCheaterModeOn: Bool?
    var highestScore: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highestScore = UserDefaults.standard.double(forKey: "myHighestScore")
        
        generateRandomNumber()
        targetLabel.text = String(format: "Your Target : %.2f", randomNumber)
    }
    
    //MARK: IBActions
    @IBAction func readyButtonPressed(_ sender: Any) {
        checkTarget(target: randomNumber, result: Double(sliderOutlet.value))
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if isCheaterModeOn != nil && isCheaterModeOn! {
            resultLabel.text = String(format: "%.2f", sender.value)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: HelperFunctions
    func generateRandomNumber() {
        randomNumber = Double.random(in: 1...100)
    }
    
    func checkTarget(target: Double, result: Double) {
        let pointStart = target - 4.0
        let pointEnd = target + 4.0
        
        if (result >= pointStart) && (result <= pointEnd) {
            getCurrentHighScore(target: target, result: result)
            
            showResult(
                title: "Bulls Eye!",
                message: String(format: "Your are hitting : %.2f", sliderOutlet.value)
            )
        } else {
            showResult(
                title: "Loser!",
                message: String(format: "Your are hitting : %.2f", sliderOutlet.value)
            )
        }
    }
    
    func updateUI() {
        generateRandomNumber()
        targetLabel.text = String(format: "Your Target : %.2f", randomNumber)
        sliderOutlet.value = 0
    }
    
    func showResult(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let submitButton = UIAlertAction(title: "OK", style: .default) { (action) in
            self.updateUI()
        }
        
        alertController.addAction(submitButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getCurrentHighScore(target: Double, result: Double) {
        var currentScore: Double!
        
        if target < result {
            currentScore = result - target
        } else {
            currentScore = target - result
        }
        
        compareHighScore(currentScore: currentScore!)
    }
    
    func compareHighScore(currentScore: Double) {
        if highestScore != nil && (highestScore! > currentScore) {
            highestScore = currentScore
            
            showResult(
                title: "New Record",
                message: String(format: "Your new record is : %.2f", highestScore!)
            )
            
            UserDefaults.standard.set(highestScore, forKey: "myHighestScore")
            UserDefaults.standard.synchronize()
        } else {
            highestScore = currentScore
        }
    }
}
