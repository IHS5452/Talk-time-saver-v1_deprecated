//
//  ViewController.swift
//  Talk Time
//
//  Created by Ian Schrauth on 9/26/20.
//

import UIKit
import Firebase


class historyViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

    var date = ""

    var hoursWorked = [String]()
    var hour:Int = 0
    var min:Int = 0
    var sec:Int = 0
    
    @IBOutlet weak var barText: UINavigationItem!
    
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barText.title = date
        var ref = Database.database().reference()
        let defaults = UserDefaults.standard
        let emailToken = defaults.string(forKey: "email")
        var emailReplacementChars1 = emailToken!.replacingOccurrences(of: "@", with: "(at)")
        var emailReplacementChars2 = emailReplacementChars1.replacingOccurrences(of: ".", with: "(dot)")
        
        ref.child("users").child(emailReplacementChars2).child("datesEnt").child(date).observeSingleEvent(of: .value, with: { [self] (snapshot) in
            let value = snapshot.value as? NSDictionary

            for child in snapshot.children {
//                    let snap = child as! DataSnapshot
//                    let song = snap.key
                self.hoursWorked.append((child as AnyObject).value)
            }
            
            self.table.reloadData()
            print("Aray has this in it: \(self.hoursWorked)")
            self.addTime()
            totalTime.text = "\(self.hour):\(self.min):\(self.sec)"
        })
    
  
        
    }
    
    func addTime() {
        for i in 0...hoursWorked.count-1 {
            var selectedTime: String = hoursWorked[i]
            let fullNameArr = selectedTime.split{$0 == ":"}.map(String.init)
            hour += Int(fullNameArr[0]) ?? 0
            min += Int(fullNameArr[1]) ?? 0
            sec += Int(fullNameArr[2]) ?? 0
            
        }
        for n in 1...99999 {
            if (min == 60) {
                min = 0
                hour += 1
            } else if (min >= 60) {
                min = min - 60
                hour += 1
            }
            if (sec == 60) {
                sec = 0
                min += 1
            }else if (sec >= 60) {
                sec = sec - 60
                min += 1
            }
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

    

    
}

/*   let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")

view.addGestureRecognizer(tap)
*/
