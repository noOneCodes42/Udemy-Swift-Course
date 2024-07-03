//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    @IBOutlet weak var titleChanger: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
                
    }
    let eggtimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var secondRemaning = 60
    var timer = Timer()
    var progressreturn: Float = 60
    @IBAction func hardnessSelector(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0
        let hardness = sender.currentTitle!
        progressreturn=Float(eggtimes[hardness]!)
        secondRemaning=eggtimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    @objc func updateTimer() {
        let math = 1/progressreturn
        if secondRemaning > 0{
            secondRemaning -= 1
            progressBar.progress += Float(math)
        }else{
            timer.invalidate()
            playSound()
            titleChanger.text = "DONE!"
            
            
        }
    }
   
    
}

