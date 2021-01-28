//
//  ViewController.swift
//  Talk Time
//
//  Created by Ian Schrauth on 9/26/20.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore


class ForgotPasswordViewController: UIViewController {
  
    @IBOutlet weak var email: UITextField!
    var auth = Auth.auth()
    
    @IBAction func sendEmail_pressed(_ sender: Any) {
        var emailAddress = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var ES = easySwiftAPI()

        if (email.text! == "") {
            ES.showPopup(selfCall: self, title: "Error", message: "Error: No email entered. Please enter an email", dismissButtonText: "Okay")
        }else {
            
            Auth.auth().sendPasswordReset(withEmail: emailAddress) { error in
                ES.showPopup(selfCall: self, title: "Sucess", message: "You should recieve an email soon!", dismissButtonText: "Okay")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

