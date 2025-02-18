//
//  time.swift
//  Talk Time Saver
//
//  Created by Ian Schrauth on 7/4/21.
//

import Foundation


class time {
    
    public static var hour = 0
    public static var min = 0
    public static var sec = 0
    
    
    

    public static  var hoursWorked = [Int]()
    public static  var minWorked = [Int]()
    public static  var secWorked = [Int]()

    
  
    
    func getHourArrayAt(atPosition: Int) -> Int {
        return time.hoursWorked[atPosition]
    }
       
    func getMinArrayAt(atPosition: Int) -> Int {
        return time.minWorked[atPosition]
    }
    
    func getSecArrayAt(atPosition: Int) -> Int {
        return time.secWorked[atPosition]
    }
    
    func getHourArray() -> [Int] {
        return time.hoursWorked
    }
       
    func getMinArray() -> [Int] {
        return time.minWorked
    }
    
    func getSecArray() -> [Int] {
        return time.secWorked
    }
    
    
    func clearHourArray() {
        time.hoursWorked.removeAll()
        print(time.hoursWorked)
    }
    func clearMinArray() {
        time.minWorked.removeAll()
        print(time.minWorked)
    }
    func clearSecArray() {
        time.secWorked.removeAll()
        print(time.secWorked)
    }

    
    
    
    
    
    func setHour(input: Int)  {
        time.hour = input
        print("Hour equals: \(time.hour)")
    }
    func setMin(input: Int) {
        time.min = input
        print("Minute equals: \(time.min)")
    }
    func setSec(input: Int) {
        time.sec = input
        print("Sec equals: \(time.sec)")
    }
    
    
    func getHour() -> Int {
        return time.hour
    }
    
    
    func getMin() -> Int {
        return time.min
    }
    
    func getSec() -> Int {
        return time.sec
    }
    
    
    

    
    
    
}
