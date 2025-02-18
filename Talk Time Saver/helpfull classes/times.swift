//
//  custom_times.swift
//  Talk Time Saver
//
//  Created by Ian Schrauth on 7/3/21.
//

import Foundation
import UIKit


class times {
    
    var hourReported:Int = 0
    var minReported:Int = 0
    var secReported:Int = 0
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    let sw = stopwatch()
    
    
    func startTimer(label: UILabel) {
        if(isPlaying) {
            return
        }
  
            
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer(label)), userInfo: nil, repeats: true)
        isPlaying = true
    }
        
     func pauseTimer() {

            
        timer.invalidate()
        isPlaying = false
    }

     func resetTimer() {

            
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        timeLabel.text = String(counter)
    }

    @objc func UpdateTimer() {
        counter = counter + 0.1
        
        timeLabel.text = String(format: "%.1f", counter)
    }


    
    
    
}
