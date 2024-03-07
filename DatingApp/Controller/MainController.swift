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
        let cardView1 = CardView()
        let cardView2 = CardView()
        cardView.addSubview(cardView1)
        cardView.addSubview(cardView2)
        cardView1.fillSuperview()
        cardView2.fillSuperview()
    }
}
