//
//  Register.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/6/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit
import Firebase

class Register: UIViewController {

    //Outlets
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpass: UITextField!
    @IBOutlet weak var acriviryindicator: UIActivityIndicatorView!
    @IBOutlet weak var passCheckimg: UIImageView!
    @IBOutlet weak var confirmCheckimg: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        password.addTarget(self, action: #selector(textFeildDidChange(_:)), for: .editingChanged)
        confirmpass.addTarget(self, action: #selector(textFeildDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFeildDidChange(_ textfeild: UITextField){
        guard let passtext  = password.text else {return}
        
        if textfeild == confirmpass {
            passCheckimg.isHidden = false
            confirmCheckimg.isHidden = false
        } else  {
            if passtext.isEmpty {
                passCheckimg.isHidden = true
                confirmCheckimg.isHidden = true
                confirmpass.text = ""
            }
        }
        
        
        //turn checkmarks to green when passwords match
        if password.text == confirmpass.text {
            passCheckimg.image = UIImage(named: "green_check")
            confirmCheckimg.image = UIImage(named: "green_check")
        }
        else {
            passCheckimg.image = UIImage(named: "red_check")
            confirmCheckimg.image = UIImage(named: "red_check")
        }
        
    }

    @IBAction func registerClicked(_ sender: Any) {
        acriviryindicator.startAnimating()
        
        guard let email = email.text , !email.isEmpty ,let password = password.text , !password.isEmpty , let username = username.text , !username.isEmpty else {
            simpleAlartforSomeError(title: "Error", message: "Please fill all feilds")
            
            return}
        
        guard let confirmtext = confirmpass.text , confirmtext == password else {
            simpleAlartforSomeError(title: "Error", message: "Passwords  dont match")
            return
        }
        
        guard let userAuth = Auth.auth().currentUser else {return}
        let credenial = EmailAuthProvider.credential(withEmail: email, link: password)
        userAuth.linkAndRetrieveData(with: credenial) { (result, error) in
            if let error  = error {
                Auth.auth().handleFireAuthError(error: error, vc: self)
            }
            self.acriviryindicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
        
        
        
    }
    


}
