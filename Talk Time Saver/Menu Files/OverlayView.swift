import UIKit
import Foundation
import UIKit


 

class OverlayView: UIViewController {
    
    @IBOutlet weak var pin_TEXT: UITextField!
    var iboNum = "";
    var password: String = "";
    var name = "";
    var em = "";
        @IBOutlet weak var ibo: UITextField!
        @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var email: UITextField!

    
    
    @IBOutlet weak var caAccount: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    @IBOutlet weak var slideIdicator: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subscribeButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)

    }
    
    @IBAction func authenticate(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        let pinTheUserCreated = defaults.string(forKey: "pin_user_created")
        
        
        if (pin_TEXT.text == pinTheUserCreated) {
            defaults.set("true", forKey: "authd")
            self.dismiss(animated: true) {
                self.pin_TEXT.text = ""
            }

        }else {
            let alert = UIAlertController(title: "Wrong PIN number", message: "The PIN number you entered is wrong. please try agaion.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
               
                   self.present(alert, animated: true)
            pin_TEXT.text = ""
        }
        
        
    }
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
        
        self.setupToHideKeyboardOnTapOnView()
            
               
                let defaults = UserDefaults.standard
                let iboToken = defaults.string(forKey: "iboNum")
                let emailToken = defaults.string(forKey: "email")

     
         
                      
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
