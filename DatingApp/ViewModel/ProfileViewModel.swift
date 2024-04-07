//
//  ProfileViewModel.swift
//  DatingApp
//
//  Created by muhammed dursun on 7.04.2024.
//

import UIKit

struct ProfileViewModel {
    
    private let userModel : UserModel
    var imageCount : Int {
        return userModel.imageURLS.count
    }
    let userDetailsAttributed: NSAttributedString
    let job : String
    let bio : String
    var imageURLS : [URL] {
        return userModel.imageURLS.map({URL(string: $0)!})
    }
    
    init(userModel: UserModel) {
        self.userModel = userModel
        let attributedText = NSMutableAttributedString(string: userModel.name,
                                                       attributes: [.font:UIFont.systemFont(ofSize: 20,weight:.semibold)])
        attributedText.append(NSAttributedString(string: " \(userModel.age) ",
                                                 attributes: [.font:UIFont.systemFont(ofSize: 18)]))
        userDetailsAttributed = attributedText
        job = userModel.job
        bio = userModel.bio
    }
    
}
