//
//  Product.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/10/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import Foundation
import FirebaseFirestore


struct Product {
    var name: String
    var imageurl:String
    var id: String
    var category:String
    var price :Double
    var description:String
    var timeStamp : Timestamp
    var stock : Double
    
    
    init(data:[String:Any]){
        
        name = data["name"] as? String ?? "nothind"
        imageurl = data["imageurl"] as? String ?? ""
        id = data["id"] as? String ?? ""
        category = data["category"] as? String ?? ""
        price = data["price"] as? Double ?? 0.0
        timeStamp = data["timestamp"] as? Timestamp ?? Timestamp()
        description = data["description"] as? String ?? ""
        stock = data["stock"] as? Double ?? 0.0


    }
    init(name: String,id: String ,imageurl: String,category: String,price: Double, stock: Double , description : String, timeStamp: Timestamp ) {
        self.name = name
        self.imageurl = imageurl
        self.id = id
        self.category = category
        self.price = price
        self.description = description
        self.timeStamp = timeStamp
        self.stock = 0.0
    }
    
    func convertModelToDictionary(product : Product) -> [String: Any]
    {
        let data : [String : Any] = [
        "name" : product.name,
        "id": product.id,
        "imageurl": product.imageurl,
        "category": product.category ,
        "price": product.price,
        "description": product.description,
        "timeStamp": product.timeStamp,
        "stock": product.stock
        ]
        return data
    }
    
    
}
