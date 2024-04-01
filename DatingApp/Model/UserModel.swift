//
//  UserModel.swift
//  DatingApp
//
//  Created by muhammed dursun on 8.03.2024.
//

import UIKit

struct UserModel {
    var name : String
    var age : Int
    var email : String
    let uid : String
    let imageURLS:[String]
    var job : String
    var minSeekingAge : Int
    var maxSeekingAge : Int
    var bio : String
    
    init(dictionary: [String:Any]) {
        self.name = dictionary["fullName"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.email = dictionary["email"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.imageURLS = dictionary["imageURLS"] as? [String] ?? [String]()
        self.job = dictionary["job"] as? String ?? ""
        self.minSeekingAge = dictionary["minSeekingAge"] as? Int ?? 18
        self.maxSeekingAge = dictionary["maxSeekingAge"] as? Int ?? 65
        self.bio = dictionary["bio"] as? String ?? ""
    }
}


