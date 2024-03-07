//
//  CardView.swift
//  DatingApp
//
//  Created by muhammed dursun on 7.03.2024.
//

import UIKit

class CardView : UIView{
    
    // MARK: - Properties
    
    private let imageView : UIImageView = {
       let imagView = UIImageView()
        imagView.contentMode = .scaleAspectFill
        imagView.image = UIImage(named: "kelly3")
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
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
}
