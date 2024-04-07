//
//  LowerStackViews.swift
//  DatingApp
//
//  Created by muhammed dursun on 7.03.2024.
//

import UIKit

protocol LowerStackViewsDelegate: class {
    func touchLike()
    func touchDislike()
    func touchRefresh()
}

class LowerStackViews : UIStackView {
    
    // MARK: - Properties
    let likeButton = UIButton(type: .system)
    let dislikeButton = UIButton(type: .system)
    let superlikeButton = UIButton(type: .system)
    let boostButton = UIButton(type: .system)
    let refreshButton = UIButton(type: .system)
    weak var delegate : LowerStackViewsDelegate?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 95).isActive = true
        distribution = .fillEqually
        refreshButton.setImage(UIImage(named: "refresh_circle")?.withRenderingMode(.alwaysOriginal), for:.normal)
        dislikeButton.setImage(UIImage(named: "dismiss_circle")?.withRenderingMode(.alwaysOriginal), for:.normal)
        likeButton.setImage(UIImage(named: "like_circle")?.withRenderingMode(.alwaysOriginal), for:.normal)
        superlikeButton.setImage(UIImage(named: "super_like_circle")?.withRenderingMode(.alwaysOriginal), for:.normal)
        boostButton.setImage(UIImage(named: "boost_circle")?.withRenderingMode(.alwaysOriginal), for:.normal)
        refreshButton.addTarget(self, action: #selector(touchRefreshButton), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(touchLikeButton), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(touchDislikeButton), for: .touchUpInside)
        [refreshButton,dislikeButton,superlikeButton,likeButton,boostButton].forEach { view in
            addArrangedSubview(view)
        }
       
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func touchRefreshButton(){
        delegate?.touchRefresh()
    }
    
    @objc func touchLikeButton(){
        delegate?.touchLike()
    }
    
    @objc func touchDislikeButton(){
        delegate?.touchDislike()
    }
}
