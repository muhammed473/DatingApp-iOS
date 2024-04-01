//
//  SettingsView.swift
//  DatingApp
//
//  Created by muhammed dursun on 17.03.2024.
//

import UIKit
import SDWebImage

protocol HeaderPhotosViewsDelegate : class{
    func setHeaderPhotosViews(headerPhotos: HeaderPhotosViews, didSelect index:Int)
}

class HeaderPhotosViews: UIView{
    
    // MARK: - Properties
    
    private let userModel:UserModel
    var allButtons = [UIButton]()
    weak var delegate : HeaderPhotosViewsDelegate?
    
    // MARK: - Lifecycle
    
     init(userModel: UserModel) {
         self.userModel = userModel
        super.init(frame: .zero)
        backgroundColor = .systemGroupedBackground
        let button1 = createButtons(index: 0)
        let button2 = createButtons(index: 1)
        let button3 = createButtons(index: 2)
        allButtons.append(button1)
        allButtons.append(button2)
        allButtons.append(button3)
        addSubview(button1)
        button1.anchor(top:topAnchor,left: leftAnchor,bottom: bottomAnchor,paddingTop: 15,paddingLeft: 15,paddingBottom: 16)
        button1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
        
        let stacks = UIStackView(arrangedSubviews: [button2,button3])
        stacks.axis = .vertical
        stacks.distribution = .fillEqually
        stacks.spacing = 15
        addSubview(stacks)
        stacks.anchor(top:topAnchor,left: button1.rightAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 15,paddingLeft: 15,paddingBottom: 15,paddingRight: 15)
        loadUserPhotos()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Assistans
    
    func loadUserPhotos() {
        let imageURLS = userModel.imageURLS.map({URL(string: $0)})
        for (index,url) in imageURLS.enumerated() {
            SDWebImageManager.shared.loadImage(with: url,options:.continueInBackground,progress: nil){ image,_,_,_,_,_ in
                self.allButtons[index].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
    
    func createButtons(index:Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Photo Select", for: .normal)
        button.addTarget(self, action: #selector(touchPhotoSelect), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.tag = index
        return button
    }
    
    // MARK: - Actions
    
    @objc func touchPhotoSelect(sender: UIButton) {
        delegate?.setHeaderPhotosViews(headerPhotos: self, didSelect: sender.tag)
    }
    
}
