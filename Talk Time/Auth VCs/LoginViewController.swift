//
//  ViewController.swift
//  Talk Time
//
//  Created by Ian Schrauth on 9/26/20.
//

import UIKit
import FirebaseAuth
import Firebase
extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

class LoginViewController: UIViewController  {
    

    
    
    //login VC outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginNote: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBAction func logout(_ sender: UIButton) {
        var ref = Database.database().reference()

        let defaults = UserDefaults.standard
        defaults.setValue("", forKey: "email")
        
        self.dismiss(animated: true, completion: {
            let alert = UIAlertController(title: "Sucess", message: "Logout sucesfull. Please login to create an order.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            

            self.present(alert, animated: true)
        })
    }
   
    var vc: ViewController?
    
    @IBAction func fp_pressed(_ sender: UIButton) {
      
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "fp") as! ForgotPasswordViewController
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
    


    
    }
    @IBAction func login(_ sender: UIButton) {
        
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            if (error != nil) {
                let alert = UIAlertController(title: "Error Signing in", message: "Error: \(error) Please Try again. If you do not have an account, please create one by clicking the button at the bottom.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
            self.present(alert, animated: true)
            } else {
                let defaults = UserDefaults.standard
                defaults.setValue(self.emailTextField.text!, forKey: "email")
                             
           self.dismiss(animated: true, completion: nil)
            }         // ...
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupToHideKeyboardOnTapOnView()

        let defaults = UserDefaults.standard
        let emailToken = defaults.string(forKey: "email")
        
        emailTextField.text = emailToken
        if (emailTextField.text != "") {
            loginButton.isEnabled = false
            loginNote.isHidden = false
            logoutButton.isHidden = false
        }
        
    }
    
    
    
    
    @IBAction func sign_up_clicked(_ sender: UIButton) {
        

        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SU") as! singUpViewController
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
   
    
}



