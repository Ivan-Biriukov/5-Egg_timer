//
//  ViewController.swift
//  Egg_timer
//
//  Created by иван Бирюков on 25.01.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft": 300, "Medium": 400, "Hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func hardnesSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!

        timerLabel.text = hardness
        progressBar.progress = 0.0
        secondsPassed = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        totalTime = eggTimes[hardness]!
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            timerLabel.text = "Done"
            playSound(soundName: "alarmSound")
        }
    }
}

