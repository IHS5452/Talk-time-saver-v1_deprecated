//
//  ViewController.swift
//  Talk Time
//
//  Created by Ian Schrauth on 9/26/20.
//

import UIKit
import Firebase
import GoogleMobileAds




class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var bannerView: GADBannerView!

    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var hoursTXTField: UITextField!
    @IBOutlet weak var minTXTField: UITextField!
    @IBOutlet weak var secTXTField: UITextField!
    
    @IBOutlet weak var regsiter: UIBarButtonItem!
    @IBOutlet weak var showHistory: UIBarButtonItem!
 
    
    var hourReported:Int = 0
    var minReported:Int = 0
    var secReported:Int = 0

    
    

    var totalString = ""
    var hoursWorked = [Int]()
    var minWorked = [Int]()
    var secWorked = [Int]()

    
    
    let date = Date()
    let formatter = DateFormatter()

    
    
    @IBAction func saveAllTimes(_ sender: UIButton) {
       
 
            
        
        
        var ref = Database.database().reference()
        let defaults = UserDefaults.standard
        let emailToken = defaults.string(forKey: "email")

        if (emailToken == "") {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "login") as! LoginViewController
            let nc = UINavigationController(rootViewController: vc)
            self.present(nc, animated: true, completion: nil)
        } else {
        
        
        
        
        //only for Firebase Database refrence
        var emailReplacementChars1 = emailToken!.replacingOccurrences(of: "@", with: "(at)")
        var emailReplacementChars2 = emailReplacementChars1.replacingOccurrences(of: ".", with: "(dot)")
        formatter.dateFormat = "MM-dd-yyyy"
        let currentDate = formatter.string(from: date)
        
        
      
        var numberOfShifts = 1
        var listOfShifts = [String]()
        ref.child("users").child(emailReplacementChars2).child("datesEnt").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary

            for child in snapshot.children {
//                    let snap = child as! DataSnapshot
//                    let song = snap.key
                listOfShifts.append((child as AnyObject).key)
            }
            
            print("listOfShifts array has this in it: \(listOfShifts)")
            numberOfShifts += listOfShifts.count
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        var i = 0
            for x in 0...self.hoursWorked.count-1 {
            print("i is \(i)")
                ref.child("users").child(emailReplacementChars2).child("datesEnt").child("\(currentDate): Shift Number \(numberOfShifts)").child(String(describing: x)).setValue("\(self.hoursWorked[i]):\(self.minWorked[i]):\(self.secWorked[i])")
            i+=1
            
        }
        i = 0
        
        let alert = UIAlertController(title: "Sucess", message: "Sucesfully saved your times!", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))

    self.present(alert, animated: true)
        }
    
    
    }
    }
    

    
    
    
    @IBAction func addToTable(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        let emailToken = defaults.string(forKey: "email")
        
        if (emailToken == "") {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.present(nextViewController, animated:true, completion:nil)
        }else {
            
            
            
        hourReported += Int(hoursTXTField.text!) ?? 0
        minReported += Int(minTXTField.text!) ?? 0
        secReported += Int(secTXTField.text!) ?? 0

        
        
        
        
        
    
        correctlyFormatTime()
        
        
            hoursWorked.append(Int(String(format: "%02d", hourReported))!)
            minWorked.append(Int(String(format: "%02d", minReported))!)
            secWorked.append(Int(String(format: "%02d", secReported))!)
        
        
        
        getTotalTime(hoursWorked, timeType: "h")
        getTotalTime(minWorked, timeType: "m")
        getTotalTime(secWorked, timeType: "s")

        
        
           
        
        
        totalTimeLabel.text = "\(String(format: "%02d", hourReported)):\(String(format: "%02d", minReported)):\(String(format: "%02d", secReported))"

        hoursTXTField.text = "00"
        minTXTField.text = "00"
        secTXTField.text = "00"
        hourReported = 0
        minReported = 0
        secReported = 0

        
        
        
        self.view.endEditing(true)
        self.table.reloadData()

    }
    }
    



    @IBAction func showHistory(_ sender: UIBarButtonItem) {
        
      var ES = easySwiftAPI()
        
        let defaults = UserDefaults.standard
        let emailToken = defaults.string(forKey: "email")
        
        if (emailToken == "") {
            ES.showPopup(selfCall: self, title: "Error", message: "You are not logged in. Please log in first.", dismissButtonText: "Okay")
        } else {
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "SPH") as! ShowPastRecordsViewController
            let nc = UINavigationController(rootViewController: vc)
            self.present(nc, animated: true, completion: nil)
        }
        
        
    }
    


    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hoursWorked.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text = "\(hoursWorked[indexPath.row]):\(minWorked[indexPath.row]):\(secWorked[indexPath.row])"
        
        cell.textLabel?.text = text
        
      
        return cell
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            hoursWorked.remove(at: indexPath.row)
            minWorked.remove(at: indexPath.row)
            secWorked.remove(at: indexPath.row)
            
            
          
            getTotalTime(hoursWorked, timeType: "h")
            getTotalTime(minWorked, timeType: "m")
            getTotalTime(secWorked, timeType: "s")
            print(hoursWorked)
            print(minWorked)
            print(secWorked)

           
            totalTimeLabel.text = "\(String(format: "%02d", hourReported)):\(String(format: "%02d", minReported)):\(String(format: "%02d", secReported))"

            self.table.reloadData()


            
        } else if editingStyle == .insert {

        }
    }


    
    
    func correctlyFormatTime() {
        
        while (minReported >= 60) {
            minReported = minReported - 60
            hourReported += 1
            
            if (minReported == 60) {
                minReported = 0
                hourReported += 1
            }
        }
        
        while (secReported >= 60) {
            secReported = secReported - 60
            minReported += 1
            
            if (secReported == 60) {
                secReported = 0
                minReported += 1
            }
        }
        
        
    }


    
    
    func getTotalTime(_ array: [Int], timeType: String){
        // getting the summation of minutes and seconds
        
        if (timeType.lowercased() == "h") {
            hourReported = array.reduce(0,+)
            correctlyFormatTime()

        }
        
        if (timeType.lowercased() == "m") {
            minReported = array.reduce(0,+)
            correctlyFormatTime()

        }
        
        if (timeType.lowercased() == "s") {
            secReported = array.reduce(0,+)
            correctlyFormatTime()

        }
        
    }
  

    @IBAction func register_pressed(_ sender: UIBarButtonItem) {
        var ES = easySwiftAPI()
        let defaults = UserDefaults.standard
        let emailToken = defaults.string(forKey: "email")
        
        
        if (emailToken == "") {
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "SU") as! singUpViewController
            let nc = UINavigationController(rootViewController: vc)
            self.present(nc, animated: true, completion: nil)
        } else {
            ES.showPopup(selfCall: self, title: "Error", message: "You alreasy have an account. Please log out beofre creating a new one.", dismissButtonText: "Okay")
        }
        
        
    }
    

    @IBAction func login_pressed(_ sender: UIBarButtonItem) {
        var ES = easySwiftAPI()
        let defaults = UserDefaults.standard
        let emailToken = defaults.string(forKey: "email")
     
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "login") as! LoginViewController
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
        
    }
    


override func viewDidLoad() {
    super.viewDidLoad()

    

    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")

    view.addGestureRecognizer(tap)
    
    let defaults = UserDefaults.standard
    let emailToken = defaults.string(forKey: "email")

}

  
    
    






@objc override func dismissKeyboard() {
 //Causes the view (or one of its embedded text fields) to resign the first responder status.
 view.endEditing(true)
}



    


}
