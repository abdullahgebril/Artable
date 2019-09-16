//
//  ForgotPassword.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/9/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit
import Firebase

class ForgotPassword: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelClicked(_ sender: Any) {
      
     
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPasswordClicked(_ sender: Any) {
        guard let emial = email.text , !emial.isEmpty else {
            
            simpleAlartforSomeError(title: "Error", message: "Please enter invald email")
            return
            
        }
        Auth.auth().sendPasswordReset(withEmail: emial) { error in
            if let error = error {
                Auth.auth().handleFireAuthError(error: error, vc: self)
                
            }
            self.dismiss(animated: true, completion: nil)
            
        }
        dismiss(animated: true, completion: nil)
    }
    

}
