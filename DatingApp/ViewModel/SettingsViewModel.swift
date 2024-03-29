//
//  SettingsViewModel.swift
//  DatingApp
//
//  Created by muhammed dursun on 21.03.2024.
//

import UIKit

enum SettingsSection:Int, CaseIterable {
    case name
    case job
    case age
    case bio
    case ageRange
    
    var description : String {
        switch self {
        case .name: return "Name"
        case .job: return "Job"
        case .age: return "Age"
        case .bio: return "Bio"
        case .ageRange: return "Seeking Age Range"
        }
    }
}

struct SettingsViewModel {
    private let userModel : UserModel
     let sections : SettingsSection
    let placeHolder: String
    var value : String?
    
    var inputFieldHidingStatus : Bool {
        return sections == .ageRange
    }
    var sliderHidingStatus : Bool {
        return sections != .ageRange
    }
    
    init(userModel:UserModel,sections:SettingsSection){
        self.userModel = userModel
        self.sections = sections
        placeHolder = "Enter \(sections.description.lowercased()).."
        switch sections {
        case .name:
            value = userModel.name
        case .job:
            value = userModel.job
        case .age:
            value = "\(userModel.age)"
        case .bio:
            value = userModel.bio
        case .ageRange:
            break
        }
    }
}
