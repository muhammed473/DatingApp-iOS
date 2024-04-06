//
//  ProfileController.swift
//  DatingApp
//
//  Created by muhammed dursun on 6.04.2024.
//

import UIKit

class ProfileController:UIViewController {
   
    // MARK: - Properties
     
    private let userModel : UserModel

    // MARK: - Lifecycle

    init(userModel:UserModel){
        self.userModel = userModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Assistant
    
    func configureUI() {
        print("PRİNT: Kullanıcının ismi : \(userModel.name) ")
        view.backgroundColor = .link
    }
}

