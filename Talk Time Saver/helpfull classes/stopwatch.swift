//
//  stopwatch.swift
//  Talk Time Saver
//
//  Created by Ian Schrauth on 7/3/21.
//


import Foundation

class stopwatch {
    
    private var startTime: Date?
    
    
   
    
    
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var isRunning: Bool {
        return startTime != nil
    }
    
    func start() {
        startTime = Date()
    }
    
    func stop() {
        startTime = nil
    }
    
}
