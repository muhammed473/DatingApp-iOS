//
//  MainNavigationStackView.swift
//  DatingApp
//
//  Created by muhammed dursun on 6.03.2024.
//

import UIKit

protocol MainNavigationStackViewDelegate: class {
    func settingsShow()
    func messagesShow()
}

class MainNavigationStackView : UIStackView{
    
    // MARK: - Properties
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let datingAppIcon = UIImageView(image: UIImage(named: "app_icon"))
    weak var delegate: MainNavigationStackViewDelegate?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 75).isActive = true
        settingsButton.setImage(UIImage(named: "top_left_profile")?.withRenderingMode(.alwaysOriginal), for:.normal)
        messageButton.setImage(UIImage(named: "top_messages_icon")?.withRenderingMode(.alwaysOriginal), for:.normal)
        datingAppIcon.contentMode = .scaleAspectFit
        [settingsButton,UIView(),datingAppIcon,UIView(),messageButton].forEach { view in
            addArrangedSubview(view)
        }
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        settingsButton.addTarget(self, action: #selector(touchSettingsButton), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(touchMessageButton), for: .touchUpInside)
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchSettingsButton() {
        delegate?.settingsShow()
    }
    
    @objc func touchMessageButton(){
        delegate?.messagesShow()
    }
    
}
