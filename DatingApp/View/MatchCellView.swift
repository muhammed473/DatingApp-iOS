//
//  MatchCellView.swift
//  DatingApp
//
//  Created by muhammed dursun on 11.04.2024.
//

import UIKit

class MatchCellView: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.setDimensions(height: 76, width: 76)
        imageView.layer.cornerRadius = 76/2
        return imageView
    }()
    private let userNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13,weight: .semibold)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    var matchCellViewModel : MatchCellViewModel!{
        didSet{
            userNameLabel.text = matchCellViewModel.nameLabel
            profileImageView.sd_setImage(with: matchCellViewModel.profileImageUrl)
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stack = UIStackView(arrangedSubviews: [profileImageView,userNameLabel] )
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 3
        addSubview(stack)
        stack.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

