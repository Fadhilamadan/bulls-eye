//
//  WelcomeViewController.swift
//  BullsEye
//
//  Created by Fadhil Amadan on 7/3/20.
//  Copyright © 2020 Fadhil Amadan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var showHighScoreButtonOutlet: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var isCheaterModeOn = false
    var isShowingScore = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IBActions
    @IBAction func playButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "welcomeToGameSegue", sender: self)
    }
    
    @IBAction func cheaterSwitchValueChange(_ sender: UISwitch) {
        isCheaterModeOn = sender.isOn
    }
    
    @IBAction func showHighScore(_ sender: Any) {
        isShowingScore = !isShowingScore
        
        if isShowingScore {
            showHighScoreButtonOutlet.setTitle("Hide Score", for: .normal)
            let myHighScore = UserDefaults.standard.double(forKey: "myHighestScore")
            scoreLabel.text = String(format: "Score : %.2f", myHighScore)
        } else {
            showHighScoreButtonOutlet.setTitle("High Score", for: .normal)
            scoreLabel.text = ""
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "welcomeToGameSegue" {
            let gameVC = segue.destination as! BullsEyeViewController
            gameVC.isCheaterModeOn = isCheaterModeOn
            
            self.present(gameVC, animated: true, completion: nil)
        }
    }

}
