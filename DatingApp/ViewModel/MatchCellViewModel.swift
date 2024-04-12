//
//  MatchCellViewModel.swift
//  DatingApp
//
//  Created by muhammed dursun on 12.04.2024.
//

import Foundation

struct MatchCellViewModel {
    
    let nameLabel : String
    var profileImageUrl: URL?
    let uid : String
    
    init(matchModel: MatchModel) {
        nameLabel = matchModel.name
        profileImageUrl =  URL(string:matchModel.profileImageUrl)
        uid = matchModel.uid
    }
    
    
    
}
