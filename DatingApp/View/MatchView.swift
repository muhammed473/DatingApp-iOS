//
//  MatchView.swift
//  DatingApp
//
//  Created by muhammed dursun on 9.04.2024.
//

import UIKit

class MatchView: UIView {
    private let currentUserModel : UserModel
    private let matchedUserModel : UserModel
    
    init( currentUserModel:UserModel,matchedUserModel:UserModel) {
        self.currentUserModel = currentUserModel
        self.matchedUserModel = matchedUserModel
        super.init(frame: .zero)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
