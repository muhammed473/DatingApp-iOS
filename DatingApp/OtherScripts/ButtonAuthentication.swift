//
//  ButtonAuthentication.swift
//  DatingApp
//
//  Created by muhammed dursun on 9.03.2024.
//

import UIKit

class ButtonAuthentication : UIButton {
    
     init(title:String,buttonType: ButtonType) {
         super.init(frame: .zero)
         setTitle(title, for: .normal)
         layer.cornerRadius = 4
         titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .heavy)
         backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
         heightAnchor.constraint(equalToConstant: 45).isActive = true
         isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
