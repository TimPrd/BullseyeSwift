//
//  ViewController.swift
//  Bull's Eyes UIKit
//
//  Created by PARDIEU Timothé on 26/02/2020.
//  Copyright © 2020 PARDIEU Timothé. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var totalRoundLabel: UILabel!
    @IBOutlet weak var btnHit: UIButton!
    
    var score: Int = 0
    var targetValue: Int = 0
    var totalScore: Int = 0
    var rounds: Int = 0
    
    let MAX_SLIDE: Int = 100
    let MIN_SLIDE: Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Normal"), for: .normal)
        slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Highlighted"), for: .highlighted)
        // Même technique ici avec "Image Literal" récupérer l'image verte:
        let trackLeftImage  = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")

        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackImageResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        let trackImageResizableR = trackRightImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackImageResizable, for: .normal)
        slider.setMaximumTrackImage(trackImageResizableR, for: .normal)

        slider.minimumValue = Float(MAX_SLIDE)
        slider.minimumValue = Float(MIN_SLIDE)
        
        startNewRound()
    }
    
    func startNewRound(){
        btnHit.isEnabled = false
        increaseRound()
        if (rounds > 1){
            totalScore += getScore()
            totalScoreLabel.text = String(totalScore)
        }else{
            totalScoreLabel.text = "0"
        }
        score = 50
        slider.value = 50
        targetValue = Int.random(in: 1...100)
        target.text = String(targetValue)
        totalRoundLabel.text = getRound()
    }
    
    func increaseRound(){
        rounds += 1
    }
    
    func getRound() -> String{
            return String(rounds)
    }
    
    func getScore() -> Int{
        print(score)
        let sc = 100 - abs(targetValue - score)
        switch sc {
            case 100: return sc + 100
            case _ where abs(targetValue - score) <= 1 :return sc + 50
            default: return sc
        }
    }
    
    func getMoodForScore() -> String{
        let sc = getScore()
        switch sc {
            case _ where sc == 100 :return "🤯"
            case _ where sc >= 90 :return "🥳"
            case _ where sc >= 70 :return "🤩"
            case _ where sc >= 50 :return "😒"
            case _ where sc >= 20 :return "😢"
            case _ where sc < 20 :return "🤮"
            default: return "🤨"
        }
    }
    
    @IBAction func showAlert() {
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        let alert = UIAlertController(title: "Score", message: "You hit \(score). \n Score :\(getScore()) \(getMoodForScore())", preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    @IBAction func resetGame(_ sender: Any) -> Void{
        score = 50;
        targetValue = 0
        totalScore = 0
        rounds = 0
        self.startNewRound()
    }
    
    
    
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("The slider value is \(slider.value)")
        score = Int(slider.value.rounded())
        btnHit.isEnabled = true
    }
    



}

