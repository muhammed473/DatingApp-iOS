//
//  Service.swift
//  DatingApp
//
//  Created by muhammed dursun on 10.03.2024.
//

import Foundation
import Firebase

struct Service {
    static func uploadImage(image : UIImage,completion : @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let fileName = "PhotoId:\(NSUUID().uuidString)"
        let ref = Storage.storage().reference(withPath: "/images/\(fileName)")
        ref.putData(imageData, metadata: nil) { (metaData,error) in
            if let error = error {
                print("Resim yüklenirken hata oluştu : \(error.localizedDescription)")
                return
            }
            ref.downloadURL { (url,error) in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
    }
    
    static func fetchUserData(uuid:String,completion:@escaping(UserModel)-> Void){
        FireStoreUsers.document(uuid).getDocument { snapshot, error in
            print("SNAPSHOT : \(snapshot?.data())")
        }
    }
}
