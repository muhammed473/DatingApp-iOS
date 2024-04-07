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
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    private var cardViewModels = [CardViewModel](){
        didSet{configureCards()}
    }
    private var  userModel : UserModel?
    private var frontCardView : CardView?
    private var  cardViewArray = [CardView]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLoginCheck()
        configureUI()
        fetchUsers()
        fetchUser()
    }
    
   // MARK: - Assistant
    
    func configureUI(){
        view.backgroundColor = .white
        upperStack.delegate = self
        lowerStack.delegate = self
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
            currentCardView.delegate  = self
           // cardViewArray.append(currentCardView)
            cardView.addSubview(currentCardView)
            currentCardView.fillSuperview()
        }
        cardViewArray = cardView.subviews.map({($0 as? CardView)!})
        frontCardView = cardViewArray.last
    }
    
    func presentLoginController(){
        DispatchQueue.main.async {
            let loginController = LoginController()
            let nav = UINavigationController(rootViewController: loginController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
        
    }
    
    func performSwipeAnimation(isTouchLike: Bool){
        let translation: CGFloat = isTouchLike ? 700 : -700
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut,animations: {
            self.frontCardView?.frame = CGRect(x:translation,y:0,
                                               width: (self.frontCardView?.frame.width)!,
                                               height: (self.frontCardView?.frame.height)!)
        }) { _ in
            self.frontCardView?.removeFromSuperview()
            guard !self.cardViewArray.isEmpty else {return}
            self.cardViewArray.remove(at: self.cardViewArray.count-1)
            self.frontCardView = self.cardViewArray.last
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

// MARK: - MainNavigationStackViewDelegate

extension MainController: MainNavigationStackViewDelegate {
    func settingsShow() {
        print("PRİNT: MainController scriptinden SettingsController sınıfına geçiş yapılıyor.. ")
        guard let userModelValues = self.userModel else {return}
        let settingsController = SettingsController(userModel: userModelValues)
        settingsController.delegate = self
        let navi = UINavigationController(rootViewController: settingsController)
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true, completion: nil)
    }
    
    func messagesShow() {
        print("PRİNT: MainController scriptinden mesajlar sayfası ayarlanıyor.. ")
    }
}

// MARK: - SettingsControllerDelegate

extension MainController:SettingsControllerDelegate{
    func updatingSettingsController(settingsController: SettingsController, updateUserModel: UserModel) {
        settingsController.dismiss(animated: true)
        self.userModel = updateUserModel
    }
     
    func LogOutSettingsController(settingsController: SettingsController) {
        settingsController.dismiss(animated: true,completion: nil)
        logOut()
    }
    
}

// MARK: - CardViewDelegate

extension MainController: CardViewDelegate {
    func profileCardView(view: CardView, userModel: UserModel) {
        let profileController = ProfileController(userModel: userModel)
        profileController.modalPresentationStyle = .fullScreen
        present(profileController, animated: true, completion: nil)
    }
    
    
}

// MARK: - LowerStackViewsDelegate

extension MainController: LowerStackViewsDelegate {
    func touchLike() {
        guard let frontCard = frontCardView else {return}
        performSwipeAnimation(isTouchLike: true)
        print("PRİNT: BEĞENDİĞİM KULLANICI İSMİ : \(frontCard.cardviewModel.userModel.name)")
    }
    
    func touchDislike() {
       performSwipeAnimation(isTouchLike: false)
    }
    
    func touchRefresh() {
       
    }
    
    
}
