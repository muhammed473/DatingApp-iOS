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
    let uuid : String
    let profileImageUrl:String
    
    init(dictionary: [String:Any]) {
        self.name = dictionary["fullName"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["imageUrl"] as? String ?? ""
        self.uuid = dictionary["uuid"] as? String ?? ""
    }
}


