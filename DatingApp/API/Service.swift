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
    
    static func fetchUserData(uid:String,completion:@escaping(UserModel)-> Void){
        FireStoreUsers.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else {return}
            let userModelValues =  UserModel(dictionary: dictionary)
            completion(userModelValues)
        }
    }
    
    static  func fetchUsersData(completion : @escaping([UserModel]) -> Void) {
        var users = [UserModel]()
        FireStoreUsers.getDocuments { allPersons, error in
            allPersons?.documents.forEach({ snapshot in
                let dictionary = snapshot.data()
                let usersModelsValues = UserModel(dictionary: dictionary)
                users.append(usersModelsValues)
                if users.count == allPersons?.documents.count{
                    print("Kişi sayısı : \(allPersons?.documents.count)")
                    print("Users array count : \(users.count)")
                    completion(users)
                }
            })
        }
    }
    
    static func saveUserData(userModel:UserModel,completion: @escaping(Error?) -> Void){
        let data = [ "uid" : userModel.uid,
                     "fullName": userModel.name,
                     "imageURLS": userModel.imageURLS ,
                     "age": userModel.age,
                     "bio":userModel.bio,
                     "job":userModel.job,
                     "minSeekingAge":userModel.minSeekingAge,
                     "maxSeekingAge" : userModel.maxSeekingAge] as [String : Any]
        
        FireStoreUsers.document(userModel.uid).setData(data, completion: completion)
        
        
    }
    
    static func saveSwipesOrButtonsClick(userModel:UserModel,isLike:Bool){
        guard let uid = Auth.auth().currentUser?.uid else {return}
       // let tellLikeStatus = isLike ? 1:0
        FireStoreSwipes.document(uid).getDocument { (snapshot,error)  in
          let data =  [userModel.uid : isLike]
            if snapshot?.exists == true {
                FireStoreSwipes.document(uid).updateData(data)
            } else {
                FireStoreSwipes.document(uid).setData(data)
            }
            
        }
        
        
    }
}
