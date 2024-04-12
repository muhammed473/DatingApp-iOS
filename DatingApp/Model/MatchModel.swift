//
//  MatchModel.swift
//  DatingApp
//
//  Created by muhammed dursun on 11.04.2024.
//

import Foundation

struct MatchModel {
    let name : String
    let profileImageUrl: String
    let uid : String
    
    init( dictionary: [String:Any] ){
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
    
    
}
