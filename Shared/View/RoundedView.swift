//
//  RoundedView.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/7/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit

class RoundedButton : UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    
}

class RoundedView : UIView {
    override func awakeFromNib() {
         super.awakeFromNib()
        layer.cornerRadius = 5
        layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }

}

class RoundedImageView: UIImageView {
    override func awakeFromNib() {
         super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    
}
