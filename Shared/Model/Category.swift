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
    let id: String
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
}
