//
//  MainController.swift
//  DatingApp
//
//  Created by muhammed dursun on 6.03.2024.
//

import UIKit

class MainController: UIViewController {

    // MARK: - Properties
    
    private let upperStack = MainNavigationStackView()
    private let lowerStack = LowerStackViews()
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5 
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCards()
        
    }
    
   // MARK: - Assistant
    
    func configureUI(){
        view.backgroundColor = .white
        let stacks = UIStackView(arrangedSubviews: [upperStack,cardView,lowerStack])
        stacks.axis = .vertical
        view.addSubview(stacks)
        stacks.anchor(top:view.safeAreaLayoutGuide.topAnchor,left:view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor)
        stacks.isLayoutMarginsRelativeArrangement = true
        stacks.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stacks.bringSubviewToFront(cardView)
    }
    
    func configureCards(){
        let image1 = UIImageView(image: UIImage(named: "jane1"))
        let image2 = UIImageView(image: UIImage(named: "jane2"))
        let image3 = UIImageView(image: UIImage(named: "kelly1"))
        let image4 = UIImageView(image: UIImage(named: "kelly2"))
        let user1 = UserModel(name: "Jane Çitlenbik", age: 24, images: [image1,image2] )
        let user2 = UserModel(name: "Kelly Orban", age: 45, images: [image1,image2] )
        let cardView1 = CardView(cardviewModel: CardViewModel(userModel: user1))
        let cardView2 = CardView(cardviewModel: CardViewModel(userModel: user2))
        cardView.addSubview(cardView1)
        cardView.addSubview(cardView2)
        cardView1.fillSuperview()
        cardView2.fillSuperview()
    }
}
