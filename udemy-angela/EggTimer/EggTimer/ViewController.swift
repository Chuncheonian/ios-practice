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
    
    // MARK:- IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // MARK:- Hmm
    let eggTimes: [String: Int] = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var timer: Timer = Timer()  // Timer() Instance 생성
    var player: AVAudioPlayer!
    
    var totalTime: Int = 0
    var secondsPassed: Int = 0
    
    // MARK:- IBAction
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()  // Timer 중지
        let hardness: String = sender.currentTitle!  // One of [Soft, Medium, Hard]
        totalTime = eggTimes[hardness]!  // Key를 통해 딕셔너리의 Value를 추출할 때 나오는 Type은 Optional
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,  // 시간 간격
                                     target: self,  // 작동할 객체
                                     selector: #selector(updateTimer),  // 1초마다 작동할 Objc 함수
                                     userInfo: nil,  // 보낼 정보
                                     repeats: true)  // 반복 여부
    }

    // MARK:- Function
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()  // Timer 중지
            titleLabel.text = "DONE"
            
            // audio 재생
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play() // 음원 재생
        }
    }
}
