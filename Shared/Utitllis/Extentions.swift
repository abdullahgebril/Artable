//
//  Extentions.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/9/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit
import Firebase



extension UIViewController {
    
    
    
    
    
    
    
    func simpleAlartforSomeError(title:String ,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
             let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
          self.present(alert, animated: true)
    }
}



