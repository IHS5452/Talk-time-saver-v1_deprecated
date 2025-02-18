//
//  EasySwiftAPI.swift
//  MakeYourMealCount Mobile
//
//  Created by Ian Schrauth on 11/21/20.
//

import Foundation
import UIKit


class easySwiftAPI {
    
    func showPopup(selfCall: UIViewController, title: String ,message: String, dismissButtonText: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: dismissButtonText, style: .default, handler: nil))
           
               selfCall.present(alert, animated: true)
    }

    
    
    
    
    
    
    
    
    
    

    func GoToAntoherViewControllerInFullScreen(selfCall: UIViewController, SBCall: UIStoryboard,  firstSBIdentifiername: String, secondSBIdentifierName: String) {
        let vc = SBCall.instantiateViewController(withIdentifier: firstSBIdentifiername)
        let nc = UINavigationController(rootViewController: vc)

        selfCall.present(nc, animated: true, completion: nil)
        
     
    }
    
}


