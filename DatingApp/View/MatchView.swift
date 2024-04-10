//
//  MatchView.swift
//  DatingApp
//
//  Created by muhammed dursun on 9.04.2024.
//

import UIKit

class MatchView: UIView {
    
    // MARK: - Properties
    
    private let currentUserModel : UserModel
    private let matchedUserModel : UserModel
    private let matchImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "itsamatch"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let infoLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Sen ve Ayşe birbirinizi beğendiniz."
        return label
    }()
    private let currentUserImageView : UIImageView =  {
        let imageV = UIImageView(image: UIImage(named: "jane1"))
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        imageV.layer.borderWidth = 1.5
        imageV.layer.borderColor = UIColor.white.cgColor
        return imageV
    }()
    private let matchedUserImageView : UIImageView =  {
        let imageV = UIImageView(image: UIImage(named: "kelly1"))
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        imageV.layer.borderWidth = 1.5
        imageV.layer.borderColor = UIColor.white.cgColor
        return imageV
    }()
    private let sendMessageBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("MESAJ GÖNDER", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(touchSendMessage), for: .touchUpInside)
        
        return btn
    }()
    private let keepSwipingBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("KAYDIRMAYA DEVAM ET", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(touchKeepSwiping), for: .touchUpInside)
        return btn
    }()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    lazy var views = [matchImageView,infoLabel,currentUserImageView,matchedUserImageView,sendMessageBtn,keepSwipingBtn]
    
    
    // MARK: - Lifecycle
    
    init( currentUserModel:UserModel,matchedUserModel:UserModel) {
        self.currentUserModel = currentUserModel
        self.matchedUserModel = matchedUserModel
        super.init(frame: .zero)
        configureBlurView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Assistants
    
    func configureUI(){
        views.forEach { view in
            addSubview(view)
            view.alpha = 1
        }
        currentUserImageView.anchor(left:centerXAnchor,paddingLeft: 14)
        currentUserImageView.setDimensions(height: 130, width: 130)
        currentUserImageView.layer.cornerRadius = 70
        currentUserImageView.centerY(inView: self)
        matchedUserImageView.anchor(right:centerXAnchor,paddingRight: 14)
        matchedUserImageView.setDimensions(height: 130, width: 130)
        matchedUserImageView.layer.cornerRadius = 70
        matchedUserImageView.centerY(inView: self)
        sendMessageBtn.anchor(top:currentUserImageView.bottomAnchor,left:leftAnchor,right: rightAnchor,paddingTop: 30,paddingLeft: 45,paddingRight: 45)
        keepSwipingBtn.anchor(top:sendMessageBtn.bottomAnchor,left:leftAnchor,right: rightAnchor,paddingTop: 16,paddingLeft: 45,paddingRight: 45)
        infoLabel.anchor(left:leftAnchor,bottom: currentUserImageView.topAnchor,right: rightAnchor,paddingBottom: 30)
        matchImageView.anchor(bottom:infoLabel.topAnchor,paddingBottom: 16)
        matchImageView.setDimensions(height: 76, width: 310)
        matchImageView.centerX(inView: self)
    }
    
    func configureBlurView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchAnywhereAndDismiss))
        visualEffectView.addGestureRecognizer(tap)
        
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        visualEffectView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,options: .curveEaseOut, animations: {
            self.visualEffectView.alpha = 1
        },completion: nil)
    }
    
    // MARK: - Actions
    
    @objc func touchSendMessage() {
        
    }
    
    @objc func touchKeepSwiping() {
        
    }
    
    @objc func touchAnywhereAndDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,options: .curveEaseOut, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
}
