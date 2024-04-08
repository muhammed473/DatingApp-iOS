//
//  CardView.swift
//  DatingApp
//
//  Created by muhammed dursun on 7.03.2024.
//

import UIKit
import SDWebImage

enum DirectionSwipe : Int{
    case left = -1
    case right = 1
}

protocol CardViewDelegate: class {
    func profileCardView( view:CardView,userModel:UserModel)
    func swipedPerson(view:CardView, didLikeUser : Bool)
}

class CardView : UIView{
    
    // MARK: - Properties
   
    private let imageView : UIImageView = {
       let imagView = UIImageView()
        imagView.contentMode = .scaleAspectFill
        return imagView
    }()
    private lazy var informationLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.attributedText = cardviewModel.userInformationText
        return label
    }()
    private lazy var informationButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "info_icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(touchShowProfile), for: .touchUpInside)
        return button
    }()
    private let gradientLayer = CAGradientLayer()
    let cardviewModel : CardViewModel
    private lazy var barStackView = SegmentedBarView(numberOfSegments: cardviewModel.imageURLS.count)
    weak var delegate : CardViewDelegate?
    
    // MARK: - Lifecycle
    
    init(cardviewModel: CardViewModel) {
        self.cardviewModel = cardviewModel
        super.init(frame: .zero)
        backgroundColor = .white
        configureGestureRecognizers()
        imageView.sd_setImage(with: cardviewModel.imageUrl)
        backgroundColor = .purple
        layer.cornerRadius = 12
        clipsToBounds = true
        addSubview(imageView)
        imageView.fillSuperview()
        configureBarStackView()
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
    
    func configureBarStackView(){
        addSubview(barStackView)
        barStackView.anchor(top:topAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 7,paddingLeft: 7,paddingRight: 7,height: 4)
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
                let didLike = direction == .right
                self.delegate?.swipedPerson(view: self, didLikeUser: didLike)
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
        let location = sender.location(in: nil).x
        let showNextPhoto = location > self.frame.width / 2
        print("Bir sonraki fotoğrafı göstermek için ekranda doğru yere tıklanıldımı ? : \(showNextPhoto)")
        if showNextPhoto {
            cardviewModel.nextPhotoShow()
        }
        else {
            cardviewModel.previousPhotoShow()
        }
       // imageView.image = cardviewModel.currentImage
        imageView.sd_setImage(with: cardviewModel.imageUrl)
        barStackView.setSelected(index: cardviewModel.index)
    
    }
    
    @objc func touchShowProfile() {
        delegate?.profileCardView(view: self, userModel: cardviewModel.userModel)
    }
}
