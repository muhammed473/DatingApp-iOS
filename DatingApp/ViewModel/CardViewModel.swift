//
//  CardViewModel.swift
//  DatingApp
//
//  Created by muhammed dursun on 8.03.2024.
//

import UIKit

struct CardViewModel {
    let userModel : UserModel
    let userInformationText : NSAttributedString
    
    init(userModel: UserModel) {
        self.userModel = userModel
        
        let attributedText = NSMutableAttributedString(string: userModel.name,attributes: [.font:UIFont.systemFont(ofSize: 30,weight: .heavy),.foregroundColor:UIColor.white])
        attributedText.append(NSMutableAttributedString(string: "   \(userModel.age)",attributes: [.font:UIFont.systemFont(ofSize: 22,weight: .heavy),.foregroundColor:UIColor.white]))
        
        self.userInformationText = attributedText
    }
}
