//
//  ViewController.swift
//  Talk Time
//
//  Created by Ian Schrauth on 9/26/20.
//

import UIKit
import FirebaseAuth
import Firebase

class singUpViewController: UIViewController  {
    
    //Sing up VC Outlets
    @IBOutlet weak var SUemail: UITextField!
    @IBOutlet weak var SUpassword: UITextField!
    
   
    
    @IBAction func singUp(_ sender: UIButton) {
        var ref = Database.database().reference()

        let defaults = UserDefaults.standard

        Auth.auth().createUser(withEmail: SUemail.text!, password: SUpassword.text!) { authResult, error in
            if (error != nil) {
                let alert = UIAlertController(title: "Error creating user", message: "Error: \(error) Please Try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
            self.present(alert, animated: true)
            } else {
                var emailReplacementChars1 = self.SUemail.text?.replacingOccurrences(of: "@", with: "(at)")
                var emailReplacementChars2 = emailReplacementChars1?.replacingOccurrences(of: ".", with: "(dot)")
                ref.child("users").child(emailReplacementChars2!).child("email").setValue(self.SUemail.text)
                    
                    
                
                    print("Sucess. Going to log in now")
                    Auth.auth().signIn(withEmail: self.SUemail.text!, password: self.SUpassword.text!) { authResult, error in
                        if (error != nil) {
                            let alert = UIAlertController(title: "Error Signing in", message: "Error: \(error) Please Try again. If you do not have an account, please create one by clicking the button at the bottom.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    
                        self.present(alert, animated: true)
                        } else {
                            let defaults = UserDefaults.standard
                            defaults.setValue(self.SUemail.text!, forKey: "email")

                                         
                            
                            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)

                        }         // ...
                    }
                    
                    
                    

                    
                        
         
            }
            
        }
        
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupToHideKeyboardOnTapOnView()

        
        let defaults = UserDefaults.standard

        
        
        
    }
    
    
    
   
    
}


