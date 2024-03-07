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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureUI()
        
    }
    
   // MARK: - Assistant
    
    func configureUI(){
        view.backgroundColor = .white
        view.addSubview(upperStack)
        upperStack.anchor(top:view.safeAreaLayoutGuide.topAnchor,left:view.leftAnchor,right: view.rightAnchor)
    }
}
