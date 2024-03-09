//
//  TextFieldCustom.swift
//  DatingApp
//
//  Created by muhammed dursun on 9.03.2024.
//

import UIKit

class TextFieldCustom : UITextField {
    
    init(placeHolder : String,isSecureText:Bool? = false){
        super.init(frame: .zero)
        
        let spacerView = UIView()
        spacerView.setDimensions(height: 45, width: 10)
        leftView = spacerView
        leftViewMode = .always
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha: 0.3)
        heightAnchor.constraint(equalToConstant: 52).isActive = true
        layer.cornerRadius = 4
        attributedPlaceholder = NSAttributedString(string: placeHolder,attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.6)])
        isSecureTextEntry = isSecureText!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
