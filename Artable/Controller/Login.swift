//
//  Login.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/6/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit
import Firebase

class Login: UIViewController {

    //Outlets
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityindactor: UIActivityIndicatorView!
    @IBOutlet weak var forgotpasswordBtn: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                  Auth.auth().handleFireAuthError(error: error, vc: self)
                    
                }
            }
        }
    }
    

    @IBAction func forgetpassClicked(_ sender: Any) {
  
        let vc  = ForgotPassword()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        
       
        
        
    }
 
    
    @IBAction func loginClicked(_ sender: Any) {
        guard let email = email.text , !email.isEmpty , let password = password.text , !password.isEmpty else {
            simpleAlartforSomeError(title: "Error", message: "Please fill out all Feilds")
            return
        }
      activityindactor.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
         
            
                if let error = error {
                    Auth.auth().handleFireAuthError(error: error, vc: self!)
                    self!.activityindactor.stopAnimating()
                    return
            }
            self!.activityindactor.stopAnimating()
            self!.dismiss(animated: true, completion: nil)
            }
        
        }
    
    @IBAction func continueAsAguestClicked(_ sender: Any) {
    }
    
    
}

