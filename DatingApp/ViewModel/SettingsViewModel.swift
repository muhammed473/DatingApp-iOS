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
    
}
