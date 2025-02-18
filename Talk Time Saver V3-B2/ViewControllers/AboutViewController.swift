//
//  AboutViewController.swift
//  Talk Time Saver
//
//  Created by Ian Schrauth on 6/14/22.
//


import Foundation


class AboutViewController: UIViewController, UIViewControllerTransitioningDelegate {
    

    @IBOutlet weak var menu_bttn: UIBarButtonItem!
    

override func viewDidLoad() {
    super.viewDidLoad()

}
    
    @IBAction func menu_clicked(_ sender: UIBarButtonItem) {
        
      menu_clicked_class()
        
        
        
    }
    
    
    func menu_clicked_class() {
        menu_bttn.target = revealViewController()
        menu_bttn.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    }
