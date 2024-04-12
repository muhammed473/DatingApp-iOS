//
//  ButtonAuthentication.swift
//  DatingApp
//
//  Created by muhammed dursun on 9.03.2024.
//

import UIKit

class ButtonAuthentication : UIButton {
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 4
        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        isEnabled = false
        setTitleColor(.white, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
