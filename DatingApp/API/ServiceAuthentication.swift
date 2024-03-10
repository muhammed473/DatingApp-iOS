//
//  ServiceAuthentication.swift
//  DatingApp
//
//  Created by muhammed dursun on 10.03.2024.
//

import UIKit
import Firebase

struct AuthCredentialsModel{
    let email : String
    let fullName : String
    let password : String
    let profileImage : UIImage
}

struct AuthenticationService {
    static  func registerUser(authCredentialsModel : AuthCredentialsModel,completion: @escaping((Error?) ->Void )) {
        Service.uploadImage(image: authCredentialsModel.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: authCredentialsModel.email, password: authCredentialsModel.password){ result, error in
                if let error = error {
                    print("Kullanıcı oturum açarken hata oluştu : \(error.localizedDescription)")
                    return
                }
                guard let uuid = result?.user.uid else {return}
                let databaseData =
                [
                                    "email" : authCredentialsModel.email,
                                    "fullName" : authCredentialsModel.fullName,
                                    "imageUrl" : imageUrl,
                                    "age" : 22
                ] as [String:Any]
                Firestore.firestore().collection("users").document(uuid).setData(databaseData, completion: completion)
            }
        }
    }
}
