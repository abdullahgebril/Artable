//
//  Category.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/9/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import FirebaseFirestore
struct Category {
    var name:String
    var id: String
    var imageurl :String
    var timestamp: Timestamp
    var isActive:Bool = true
    
    

    init (data : [String:Any]) {
        self.name = data["name"] as? String ?? "nothing"
        self.id  = data["id"] as?String ?? ""
        self.imageurl = data["imageurl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
    }
    
    init(name:String , id : String , imageurl : String , isActve : Bool ,timestamp : Timestamp )
    {
       self.name = name
        self.id  = id
        self.imageurl = imageurl
        self.isActive = isActve
       self.timestamp = timestamp
    }
    
    func convertModelToDictionary(category : Category) -> [String: Any]
    {
        let data : [String : Any] = [
            "name" : category.name,
            "id" : category.id,
            "imageurl" : category.imageurl,
            "isActive" :category.isActive ,
            "timestamp": category.timestamp
        ]
        return data
    }
}
