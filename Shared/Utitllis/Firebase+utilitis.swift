//
//  Firebase+utilitis.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/9/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import Firebase

extension Auth {
    func handleFireAuthError(error: Error,vc:UIViewController){
        if let errorCode  = AuthErrorCode(rawValue: error._code){
            
            let alert = UIAlertController(title: "Error", message:errorCode.message , preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            vc.present(alert, animated: true)
        }
    }
}

extension AuthErrorCode {
    
    var message:String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account. Pick another email!"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password or email is incorrect."
            
        default:
            return "Sorry, something went wrong."
        }
    }
}

