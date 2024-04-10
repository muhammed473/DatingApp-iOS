//
//  MatchViewModel.swift
//  DatingApp
//
//  Created by muhammed dursun on 10.04.2024.
//

import Foundation

struct MatchViewModel {
    private let currentUserModel : UserModel
    private let matchedUserModel : UserModel
    let matchLabelText : String
    var currentUserImageURL: URL?
    var matchedUserImageURL: URL?
    
    init(currentUserModel: UserModel, matchedUserModel: UserModel) {
        self.currentUserModel = currentUserModel
        self.matchedUserModel = matchedUserModel
        matchLabelText = "Sen ve \(matchedUserModel.name) birbirinizi beğendiniz."
        guard let currentImageUrlString = currentUserModel.imageURLS.last else {return}
        guard let matchedImageUrlString = matchedUserModel.imageURLS.last else {return}
        currentUserImageURL = URL(string:currentImageUrlString )
        matchedUserImageURL = URL(string: matchedImageUrlString)
        
        
    }
    
}
