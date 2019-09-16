//
//  CategoryCell.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/10/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

    //Outlets
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       categoryImage.layer.cornerRadius = 5
    }
    
    func configureCell(Category:Category){
        
        categoryName.text = Category.name
        if let url = URL(string: Category.imageurl){
            categoryImage.kf.indicatorType = .activity
            let image = UIImage(named: "placeholder")

        categoryImage.kf.setImage(with: url,placeholder: image,options:[.transition(.fade(0.2))])
    }
}
}
