//
//  AuthenticationViewModel.swift
//  DatingApp
//
//  Created by muhammed dursun on 9.03.2024.
//

import Foundation

protocol AuthenticationViewModel {
    var isFormValid : Bool { get }
}

struct LoginViewModel : AuthenticationViewModel {
    var email: String?
    var password: String?
    var isFormValid : Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}

struct RegisterViewModel : AuthenticationViewModel{
    var email : String?
    var fullName : String?
    var password : String?
    var isFormValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false     && fullName?.isEmpty == false
    }
}
