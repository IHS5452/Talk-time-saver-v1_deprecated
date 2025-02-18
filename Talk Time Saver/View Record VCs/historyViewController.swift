//
//  ViewController.swift
//  Talk Time
//
//  Created by Ian Schrauth on 9/26/20.
//

import UIKit


class historyViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

    var date = ""

    var hoursWorked = [String]()
    var hour:Int = 0
    var min:Int = 0
    var sec:Int = 0
    
    @IBOutlet weak var barText: UINavigationItem!
    
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var table: UITableView!
    
    var fileClass = file()
    override func viewDidLoad() {
        super.viewDidLoad()
        barText.title = date
        
        
        var f = file()
        var a = actions()
        
        var content = f.read(fileName: date)
        
        
        var timesSeperated = content.split(separator: ",")
        
        var i = 0
        for i in 0...timesSeperated.count-1{
            self.hoursWorked.append("\(timesSeperated[i])")
            self.addTime(row: "\(timesSeperated[i])")
            totalTime.text = "\(self.hour):\(self.min):\(self.sec)"


        }

    }
    

    
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hoursWorked.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        let text = self.hoursWorked[indexPath.row]
        
        cell.textLabel?.text = text
        
      
        return cell
    }

    
    func addTime(row: String) {
//            var splitArray = array.split(separator: ",")
            var fullNameArr = row.split{$0 == ":"}.map(String.init)
           

            hour = hour + Int(fullNameArr[0])!
            min = min + Int(fullNameArr[1])!
            sec = sec + Int(fullNameArr[2])!
            print("hour: \(hour)")
            print("minute: \(min)")
            print("sec: \(sec)")
        
        while (min >= 60) {
            min = min - 60
            hour += 1
            
            if (min == 60) {
                min = 0
                hour += 1
            }
        }
        
        while (sec >= 60) {
            sec = sec - 60
            min += 1
            
            if (sec == 60) {
                sec = 0
                min += 1
            }
        }

    }
    
}

/*   let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")

view.addGestureRecognizer(tap)
*/
