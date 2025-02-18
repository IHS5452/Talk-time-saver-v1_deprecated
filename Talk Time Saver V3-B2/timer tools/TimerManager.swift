//
//  timer.swift
//  Talk Time Saver V3-B2
//
//  Created by user941142 on 2/14/25.
//

import Foundation

class TimerManager {
    private var timer: Timer?
    private var timeElapsed: TimeInterval = 0
    private var isRunning = false
    
    var timeUpdateHandler: ((String) -> Void)?
    
    func startTimer() {
        guard !isRunning else { return }
        
        isRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        guard isRunning else { return }
        
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timeElapsed = 0
        isRunning = false
        updateDisplay()
    }
    
    func resetTimer() {
        timeElapsed = 0
        updateDisplay()
    }
    
    func getTime() -> String {
        return timeFormatted()
    }
    
    @objc private func updateTime() {
        timeElapsed += 1
        updateDisplay()
    }
    
    private func updateDisplay() {
        let formattedTime = timeFormatted()
        timeUpdateHandler?(formattedTime)
    }
    
    private func timeFormatted() -> String {
        let minutes = Int(timeElapsed) / 60
        let seconds = Int(timeElapsed) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
