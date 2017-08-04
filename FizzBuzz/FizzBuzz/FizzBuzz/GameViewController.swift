//
//  GameViewController.swift
//  FizzBuzz
//
//  Created by Pablo Rodrigo Alves da Silva on 04/08/17.
//  Copyright © 2017 Pablo Rodrigo Alves da Silva. All rights reserved.
//

import UIKit
import Foundation

class GameViewController: BaseViewController {

    @IBOutlet weak var timerProgress: UIProgressView!
    
    internal var currentNumber = 1
    internal var score = 0
    
    internal let NUMBER = 1
    internal let FIZZ = 2
    internal let BUZZ = 3
    internal let FIZZ_BUZZ = 4
    
    var time = 0.0
    var timer: Timer?
    
    @IBOutlet weak var btnNumber: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerProgress.transform = CGAffineTransform(scaleX: 1, y: 20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentNumber = 0
        score = 0
        
        play()
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOptionClick(_ sender: Any) {
        stopTimer()
        
        let tag = (sender as! UIButton).tag
        var requiredTag = tag
        
        if currentNumber % 15 == 0 {
            requiredTag = FIZZ_BUZZ
        } else if currentNumber % 5 == 0 {
            requiredTag = BUZZ
        } else if currentNumber % 3 == 0 {
            requiredTag = FIZZ
        } else {
            requiredTag = NUMBER
        }
     
        if tag == requiredTag {
            let pesoPontuacaoTempo: Int = score * Int(floor(time))
            
            score = score + currentNumber - pesoPontuacaoTempo
            
            play()
        } else {
            gameOver();
        }
    }

    internal func startTimer() {
        time = 0
        stopTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { timer in
            
            let change: Float = 0.01
            self.timerProgress.setProgress(self.timerProgress.progress - (change), animated: true)
            
            if self.timerProgress.progress <= 0 {
                self.stopTimer()
                self.gameOver()
            } else {
                self.time = self.time + 0.05
            }
        })
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func gameOver() {
        stopTimer()
        performSegue(withIdentifier: "gameOver", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameOver" {
            let controller = segue.destination as! EndGameViewController
            
            controller.score = score
            controller.gameViewDeletage = self
        }
    }
}

extension GameViewController : GameDelegate {
    func play() {
        currentNumber = currentNumber + 1
        
        timerProgress.progress = 1.0
        btnNumber.setTitle(String(currentNumber), for: .normal)
        
        startTimer()
    }
}
