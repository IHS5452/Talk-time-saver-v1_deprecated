//
//  MenuViewController.swift
//  Talk Time Saver
//
//  Created by Ian Schrauth on 6/14/22.
//

import Foundation


class MenuViewController: UIViewController, UIViewControllerTransitioningDelegate {
    

    @IBAction func custTimes_clicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "cust_segue", sender: nil)
    }
    
    
    @IBAction func pinChange_clicked(_ sender: UIButton) {
        

    }
    
    @IBAction func history_clicked(_ sender: UIButton) {
        
       
            

        
        
        
    }
    
    
    @IBAction func about_clicked(_ sender: UIButton) {

 
        
        
        
    }
    
    @IBAction func home_clicked(_ sender: UIButton) {

        
    }
    


override func viewDidLoad() {
    super.viewDidLoad()
    
}

    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }

}

    
    
    





