//
//  actions.swift
//  Talk Time Saver
//
//  Created by Ian Schrauth on 7/4/21.
//

import Foundation


class actions {
    
    var tm = time()

    func saveToArray(h_m_s: String) {
        if h_m_s == "h" {
            print("Hour in saveToArray is: \(tm.getHour())")
            time.hoursWorked.append(tm.getHour())
            print(time.hoursWorked)
            getTotalTime(array: time.hoursWorked, timeType: "h")
           
        }else if h_m_s == "m" {
            print("Min in saveToArray is: \(tm.getMin())")


            time.minWorked.append(tm.getMin())
            print(time.minWorked)
            getTotalTime(array: time.minWorked, timeType: "m")
           
        } else if h_m_s == "s" {
            print("Hour in saveToArray is: \(tm.getSec())")

            time.secWorked.append(tm.getSec())
            print(time.secWorked)
            getTotalTime(array: time.secWorked, timeType: "s")
           
        }else {
            
        }
        
   
        
    }
    
    
    
    func getTotalTime(array: [Int], timeType: String){
        // getting the summation of minutes and seconds
        
        if (timeType.lowercased() == "h") {
            time.hour = array.reduce(0,+)
            correctlyFormatTime()

        }
        
        if (timeType.lowercased() == "m") {
            time.min = array.reduce(0,+)
            correctlyFormatTime()

        }
        
        if (timeType.lowercased() == "s") {
            time.sec = array.reduce(0,+)
            correctlyFormatTime()

        }
        
    }

    
    
    
    func correctlyFormatTime() {
        
        while (time.min >= 60) {
            time.min = time.min - 60
            time.hour += 1
            
            if (time.min == 60) {
                time.min = 0
                time.hour += 1
            }
        }
        
        while (time.sec >= 60) {
            time.sec = time.sec - 60
            time.min += 1
            
            if (time.sec == 60) {
                time.sec = 0
                time.min += 1
            }
        }
        
        
    }

    
    
    
    func addUpTimes_HistoryPage(array: [Int]) {
        
    }
    
    
    
    
}
