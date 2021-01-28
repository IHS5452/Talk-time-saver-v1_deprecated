//
//  ViewController.swift
//  Talk Time
//
//  Created by Ian Schrauth on 9/26/20.
//

import UIKit
import Firebase


class ShowPastRecordsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

    var retrevedHoursWorked = [String]()
    
    @IBOutlet weak var table: UITableView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        var ref = Database.database().reference()
        let defaults = UserDefaults.standard
        let emailToken = defaults.string(forKey: "email")
        var emailReplacementChars1 = emailToken!.replacingOccurrences(of: "@", with: "(at)")
        var emailReplacementChars2 = emailReplacementChars1.replacingOccurrences(of: ".", with: "(dot)")
        
        ref.child("users").child(emailReplacementChars2).child("datesEnt").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary

            for child in snapshot.children {
//                    let snap = child as! DataSnapshot
//                    let song = snap.key
                self.retrevedHoursWorked.append((child as AnyObject).key)
            }
            
            self.table.reloadData()
            print("Aray has this in it: \(self.retrevedHoursWorked)")

        })

    }

    
    
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrevedHoursWorked.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text = retrevedHoursWorked[indexPath.row]
        
        cell.textLabel?.text = text
        
      
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = storyboard!.instantiateViewController(withIdentifier: "shiftHistory") as! historyViewController
        let nc = UINavigationController(rootViewController: vc)
        vc.date = retrevedHoursWorked[indexPath.row]
        self.present(nc, animated: true, completion: nil)


    }
    
}

