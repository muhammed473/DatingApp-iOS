//
//  ProfileCellView.swift
//  DatingApp
//
//  Created by muhammed dursun on 6.04.2024.
//

import UIKit

class ProfileCellView: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "kelly1")
        addSubview(imageView)
        imageView.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
