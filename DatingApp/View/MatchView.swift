//
//  MatchView.swift
//  DatingApp
//
//  Created by muhammed dursun on 9.04.2024.
//

import UIKit

class MatchView: UIView {
    
    // MARK: - Properties
    
    private let matchViewModel: MatchViewModel
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
        let btn = SendMessageButtonView(type: .system)
        btn.setTitle("MESAJ GÖNDER", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(touchSendMessage), for: .touchUpInside)
        return btn
    }()
    private let keepSwipingBtn : UIButton = {
        let btn = KeepSwipingButtonView(type: .system)
        btn.setTitle("KAYDIRMAYA DEVAM ET", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(touchKeepSwiping), for: .touchUpInside)
        return btn
    }()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    lazy var views = [matchImageView,infoLabel,currentUserImageView,matchedUserImageView,sendMessageBtn,keepSwipingBtn]
    
    // MARK: - Lifecycle
    
    init(matchViewModel:MatchViewModel) {
        self.matchViewModel = matchViewModel
        super.init(frame: .zero)
        loadUsersData()
        configureBlurView()
        configureUI()
        configureAnimations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Assistants
    
    func configureUI(){
        views.forEach { view in
            addSubview(view)
            view.alpha = 0
        }
        currentUserImageView.anchor(right:centerXAnchor,paddingRight: 14)
        currentUserImageView.setDimensions(height: 130, width: 130)
        currentUserImageView.layer.cornerRadius = 70
        currentUserImageView.centerY(inView: self)
        matchedUserImageView.anchor(left:centerXAnchor,paddingLeft: 14)
        matchedUserImageView.setDimensions(height: 130, width: 130)
        matchedUserImageView.layer.cornerRadius = 70
        matchedUserImageView.centerY(inView: self)
        sendMessageBtn.anchor(top:currentUserImageView.bottomAnchor,left:leftAnchor,right: rightAnchor,paddingTop: 30,paddingLeft: 45,paddingRight: 45)
        sendMessageBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        keepSwipingBtn.anchor(top:sendMessageBtn.bottomAnchor,left:leftAnchor,right: rightAnchor,paddingTop: 16,paddingLeft: 45,paddingRight: 45)
        keepSwipingBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
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
    
    func configureAnimations() {
        views.forEach { $0.alpha = 1 }
        let angle = 30*CGFloat.pi/180
        currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle).concatenating(CGAffineTransform(translationX: 210, y: 0))
        matchedUserImageView.transform = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: -210, y: 0))
        self.sendMessageBtn.transform = CGAffineTransform(translationX: -450, y: 0)
        self.keepSwipingBtn.transform = CGAffineTransform(translationX: 450, y: 0)
        // MARK: - Users Images Animations
        UIView.animateKeyframes(withDuration: 1.3, delay: 0,options: .calculationModeCubic,animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
                self.matchedUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4) {
                self.currentUserImageView.transform = .identity // Başlangıç pozisyonu.
                self.matchedUserImageView.transform = .identity
            }
        },completion: nil)
        // MARK: - Buttons Animations
        UIView.animate(withDuration: 0.75, delay: 1.3 * 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1,options: .curveEaseOut, animations: {
            self.sendMessageBtn.transform = .identity
            self.keepSwipingBtn.transform = .identity
        },completion: nil )
    }
    
    func loadUsersData(){
        infoLabel.text = matchViewModel.matchLabelText
        currentUserImageView.sd_setImage(with: matchViewModel.currentUserImageURL)
        matchedUserImageView.sd_setImage(with: matchViewModel.matchedUserImageURL)
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
