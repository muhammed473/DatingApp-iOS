//
//  CardView.swift
//  DatingApp
//
//  Created by muhammed dursun on 7.03.2024.
//

import UIKit

enum DirectionSwipe : Int{
    case left = -1
    case right = 1
}

class CardView : UIView{
    
    // MARK: - Properties
    
    private let imageView : UIImageView = {
       let imagView = UIImageView()
        imagView.contentMode = .scaleAspectFill
        return imagView
    }()
    private let informationLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "Özlem Çetin",attributes: [.font:UIFont.systemFont(ofSize: 30,weight: .heavy),.foregroundColor:UIColor.white])
        attributedText.append(NSMutableAttributedString(string: "   19",attributes: [.font:UIFont.systemFont(ofSize: 22,weight: .heavy),.foregroundColor:UIColor.white]))
        label.attributedText = attributedText
        return label
    }()
    private lazy var informationButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "info_icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    private let gradientLayer = CAGradientLayer()
    private let cardviewModel : CardViewModel
    
    // MARK: - Lifecycle
    
     init(cardviewModel: CardViewModel) {
        self.cardviewModel = cardviewModel
        super.init(frame: .zero)
         
        configureGestureRecognizers()
        
         imageView.image = cardviewModel.userModel.images.first?.image
         
        backgroundColor = .purple
        layer.cornerRadius = 12
        clipsToBounds = true
        addSubview(imageView)
        imageView.fillSuperview()
        configureGradientlayer()
        addSubview(informationLabel)
        informationLabel.anchor(left : leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingLeft: 16,paddingBottom: 20,paddingRight: 16)
        addSubview(informationButton)
        informationButton.setDimensions(height: 38, width: 38)
        informationButton.centerY(inView: informationLabel)
        informationButton.anchor(right:rightAnchor,paddingRight: 16)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    // MARK: - Assistant
    
    func configureGradientlayer(){
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.4,1.0]
        layer.addSublayer(gradientLayer)
    }
    
    func configureGestureRecognizers() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(touchPanGesture))
        addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchChangePhoto))
        addGestureRecognizer(tapGesture)
    }
    
    func rotationPanCard(sender: UIPanGestureRecognizer){
        let relocate = sender.translation(in: nil)
        let degrees : CGFloat = relocate.x / 20
        let angle = degrees * .pi / 180
        let rotationRelocate = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationRelocate.translatedBy(x: relocate.x, y: relocate.y)
    }
    
    func resultSwipeIntensity(sender: UIPanGestureRecognizer){
        let direction : DirectionSwipe = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDeclineCard = abs(sender.translation(in: nil).x) > 100
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6,initialSpringVelocity: 0.1,options: .curveEaseOut,animations: {
            if shouldDeclineCard {
                let xRelocate = CGFloat(direction.rawValue) * 1000
                let offscreenTransform = self.transform.translatedBy(x: xRelocate, y: 0)
                self.transform = offscreenTransform
            }else{
                self.transform = .identity
            }
            
        }) { _ in
            print("Animation finish.")
            if shouldDeclineCard {
                self.removeFromSuperview()
            }
            
        }
    }
    
    // MARK: - Actions
    
    @objc func touchPanGesture(sender:UIPanGestureRecognizer) {
        switch sender.state{
        case .began:
            print("Swipe is starting.")
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
        case .changed:
           rotationPanCard(sender: sender)
        case .ended:
            resultSwipeIntensity(sender: sender)
        default: break
        }
        
        
    }
    
    @objc func touchChangePhoto(sender: UITapGestureRecognizer) {
        print("Fotoğrafa dokunuldu.")
    }
}
