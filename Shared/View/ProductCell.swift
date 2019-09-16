//
//  ProductCell.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/10/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit
import Kingfisher


class ProductCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTilte: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func configureCell( product:Product) {
        
        productTilte.text = product.name
        if let url = URL(string: product.imageurl){
            productImage.kf.setImage(with: url)
            
        }
        
    }

    @IBAction func addToCartClicked(_ sender: Any) {
    }
    
    @IBAction func favoriteBtnClicked(_ sender: Any) {
    }
    
}
