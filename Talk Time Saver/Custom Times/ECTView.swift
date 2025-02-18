import UIKit
import Foundation
import UIKit


 

class ECTView: UIViewController {
    

    @IBOutlet weak var sec_TF: UITextField!
    @IBOutlet weak var min_TF: UITextField!
    @IBOutlet weak var hr_TF: UITextField!
    
    
    
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
    
    @IBAction func dismiss_clicked(_ sender: UIButton) {
        
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func add_to_total(_ sender: UIButton) {
        var time_input = time()
        var ta = actions()
        
        var hrr = Int(hr_TF.text ?? "") ?? 0
        var min = Int(min_TF.text ?? "") ?? 0
        var sec = Int(sec_TF.text ?? "") ?? 0

    
        
        
        
        time_input.setHour(input: hrr)
        time_input.setMin(input: min)
        time_input.setSec(input: sec)



        
        dismiss(animated: true) {
            ta.saveToArray(h_m_s: "h")
            ta.saveToArray(h_m_s: "m")
            ta.saveToArray(h_m_s: "s")
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

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
