//
//  ProductDetails.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/16/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit

class ProductDetails: UIViewController {

    
    // Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var bgView: UIVisualEffectView!
    
    
    //Varaibles
    var product:Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDetails()
    }
    
    func setDetails() {
        productTitle.text = product.name
        productDescription.text = product.description
        
        let url = URL(string: product.imageurl)
        productImage.kf.setImage(with: url)
        
        let formatter =  NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            productPrice.text = price
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(productDismass))
        tap.numberOfTapsRequired = 1
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func productDismass() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addCartClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func keepShopingClicked(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }
    
}
