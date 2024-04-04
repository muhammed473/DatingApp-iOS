//
//  SettingsFooterView.swift
//  DatingApp
//
//  Created by muhammed dursun on 4.04.2024.
//

import UIKit

protocol SettingsFooterDelegate : class{
    func logOutProtocol()
}

class SettingsFooterView: UIView {
    
    // MARK: - Properties
    
    private lazy var logOutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("LogOut", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(touchLogOut), for: .touchUpInside)
        return btn
    }()
    weak var delegate : SettingsFooterDelegate?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let spacer = UIView()
        spacer.backgroundColor = .systemGroupedBackground
        spacer.setDimensions(height: 30, width: frame.width)
        addSubview(spacer)
        addSubview(logOutButton)
        logOutButton.anchor(top: spacer.bottomAnchor,left: leftAnchor,right: rightAnchor,height: 46)
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func touchLogOut() {
        delegate?.logOutProtocol()
    }
}


