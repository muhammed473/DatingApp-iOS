//
//  MainController.swift
//  DatingApp
//
//  Created by muhammed dursun on 6.03.2024.
//

import UIKit
import Firebase

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
    private var cardViewModels = [CardViewModel](){
        didSet{configureCards()}
    }
    private var  userModel : UserModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLoginCheck()
        configureUI()
      //  logOut()
        fetchUsers()
        fetchUser()
    }
    
   // MARK: - Assistant
    
    func configureUI(){
        view.backgroundColor = .white
        upperStack.delegate = self
        let stacks = UIStackView(arrangedSubviews: [upperStack,cardView,lowerStack])
        stacks.axis = .vertical
        view.addSubview(stacks)
        stacks.anchor(top:view.safeAreaLayoutGuide.topAnchor,left:view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor)
        stacks.isLayoutMarginsRelativeArrangement = true
        stacks.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stacks.bringSubviewToFront(cardView)
    }
    
    func configureCards(){
        print("Card'lar şimdi oluşturuluyor..")
        self.cardViewModels.forEach { cardViewModel in
            let currentCardView = CardView(cardviewModel: cardViewModel)
            cardView.addSubview(currentCardView)
            currentCardView.fillSuperview()
        }
        
    }
    
    func presentLoginController(){
        DispatchQueue.main.async {
            let loginController = LoginController()
            let nav = UINavigationController(rootViewController: loginController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
        
    }
    
    // MARK: - Firebase Connections
    
    func userLoginCheck() {
        if Auth.auth().currentUser == nil {
            presentLoginController()
        }
        else {
            print("Kullanıcı oturum açmış.")
        }
    }
    
    func logOut(){
        do{
            try Auth.auth().signOut()
            presentLoginController()
        }
        catch {
            print("Oturum kapatılamadı.")
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Service.fetchUserData(uid: uid) { userModelValues in
            self.userModel = userModelValues
        }
    }
    
    func fetchUsers(){
        Service.fetchUsersData { usersModelsValues in
         //   print("Kullanıcıların modellerinin değerleri(kullanıcılar) : \(usersModelsValues)")
            self.cardViewModels = usersModelsValues.map({CardViewModel(userModel: $0)})
           /* usersModelsValues.forEach { user in
                let viewModel = CardViewModel(userModel: user)
                self.cardViewModels.append(viewModel)*/
            }
        }
    
    }

extension MainController: MainNavigationStackViewDelegate {
    func settingsShow() {
        print("PRİNT: MainController scriptinden SettingsController sınıfına geçiş yapılıyor.. ")
        guard let userModelValues = self.userModel else {return}
        let settingsController = SettingsController(userModel: userModelValues)
        let navi = UINavigationController(rootViewController: settingsController)
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true, completion: nil)
    }
    
    func messagesShow() {
        print("PRİNT: MainController scriptinden mesajlar sayfası ayarlanıyor.. ")
    }
    
    
}

