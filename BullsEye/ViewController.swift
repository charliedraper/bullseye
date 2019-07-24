//
//  ViewController.swift
//  BullsEye
//
//  Created by Charlie Draper on 7/8/19.
//  Copyright © 2019 Charlie Draper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    
    var currentScore: Int = 0
    var currentRound: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        //Initialize the slider
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        let points = (difference == 0 ? 200 : difference == 1 ? 149 : 100 - difference)
        
        let message = "The value of the slider is \(currentValue). You scored \(points) points!"
        let title = (difference == 0 ? "You nailed it!" : "Nice try!")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.currentScore += points
            self.currentRound += 1
            self.startNewRound()
        })

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = Int(slider.value.rounded())
    }
    
    @IBAction func startOver() {
        self.startNewGame()
    }
    
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        
        self.updateLabels()
    }
    
    func startNewGame() {
        currentScore = 0
        currentRound = 1
        
        self.startNewRound()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        slider.value = Float(currentValue)
        scoreLabel.text = String(currentScore)
        roundLabel.text = String(currentRound)
    }
    
}

