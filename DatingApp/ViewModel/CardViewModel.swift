//
//  CardViewModel.swift
//  DatingApp
//
//  Created by muhammed dursun on 8.03.2024.
//

import UIKit

class CardViewModel {
    let userModel : UserModel
    let userInformationText : NSAttributedString
    private var imageIndex = 0
    var imageUrl: URL?
    let imageURLS : [String]
    
    init(userModel: UserModel) {
        self.userModel = userModel
        
        let attributedText = NSMutableAttributedString(string: userModel.name,attributes: [.font:UIFont.systemFont(ofSize: 30,weight: .heavy),.foregroundColor:UIColor.white])
        attributedText.append(NSMutableAttributedString(string: "   \(userModel.age)",attributes: [.font:UIFont.systemFont(ofSize: 22,weight: .heavy),.foregroundColor:UIColor.white]))
        
        self.userInformationText = attributedText
        self.imageURLS = userModel.imageURLS
        self.imageUrl = URL(string: self.imageURLS[0])
    }
    
   /* func nextPhotoShow(){
        guard imageIndex < userModel.images.count - 1 else {return}
        imageIndex += 1
        currentImage = userModel.images[imageIndex].image
    }
    
    func previousPhotoShow(){
        guard imageIndex > 0  else {return}
        imageIndex -= 1
        currentImage = userModel.images[imageIndex].image
    } */
}
