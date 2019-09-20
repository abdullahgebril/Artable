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
            productImage.kf.indicatorType = .activity
            let image = UIImage(named: "placeholder")
            productImage.kf.setImage(with: url)
            
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            ProductPrice.text = price
        }
        
    }

    @IBAction func addToCartClicked(_ sender: Any) {
    }
    
    @IBAction func favoriteBtnClicked(_ sender: Any) {
    }
    
}
