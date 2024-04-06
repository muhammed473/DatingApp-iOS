//
//  ProfileController.swift
//  DatingApp
//
//  Created by muhammed dursun on 6.04.2024.
//

import UIKit

private let profileCellIdentifer = "profileCell"
class ProfileController:UIViewController {
   
    // MARK: - Properties
    
    private let userModel : UserModel
    private lazy var collectionView : UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width + 100)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(ProfileCellView.self, forCellWithReuseIdentifier: profileCellIdentifer)
        return cv
    }()
    private let exitButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "dismiss_down_arrow")?.withRenderingMode(.alwaysOriginal),for: .normal)
        btn.addTarget(self, action: #selector(touchExitButton), for: .touchUpInside)
        btn.setDimensions(height: 40, width: 40)
   
        return btn
    }()
    private let infoLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Fatih DOĞRUYOL - 28"
        return label
    }()
    private let jobLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "iOS Developer"
        return label
    }()
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Merhaba en çok sevdiğim şeyler : Kitap okumak,Müzik dinlemek ve yürüyüş yapmak.."
        return label
    }()
    private lazy var disLikeButton : UIButton = {
        let btn = createButtons(image: UIImage(named: "dismiss_circle")!)
        btn.addTarget(self, action: #selector(touchDisLike), for: .touchUpInside)
        return btn
    }()
    private lazy var superLikeButton : UIButton = {
        let btn = createButtons(image: UIImage(named: "super_like_circle")!)
        btn.addTarget(self, action: #selector(touchSuperLike), for: .touchUpInside)
        return btn
    }()
    private lazy var likeButton : UIButton = {
       let btn = createButtons(image: UIImage(named: "like_circle")!)
        btn.addTarget(self, action: #selector(touchLike), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    
    init(userModel:UserModel){
        self.userModel = userModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Assistant
    
    func configureUI() {
        print("PRİNT: Kullanıcının ismi : \(userModel.name) ")
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(exitButton)
        exitButton.anchor(top:collectionView.bottomAnchor,right: view.rightAnchor,paddingTop: -20,paddingRight: 18)
        let infosStack = UIStackView(arrangedSubviews: [infoLabel,jobLabel,bioLabel])
        infosStack.axis = .vertical
        infosStack.spacing = 5
        view.addSubview(infosStack)
        infosStack.anchor(top:collectionView.bottomAnchor,left:view.leftAnchor,right: view.rightAnchor,paddingTop: 10,paddingLeft: 10,paddingRight: 10)
        configureLowerControls()
    }
    
    func configureLowerControls() {
        let stack = UIStackView(arrangedSubviews: [disLikeButton,superLikeButton,likeButton])
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.setDimensions(height: 70, width: 310)
        stack.spacing = -28
        stack.centerX(inView: view)
        stack.anchor(bottom:view.safeAreaLayoutGuide.bottomAnchor,paddingBottom: 30)
    }
    
    func createButtons(image:UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    // MARK: - Actions
    
    @objc func touchExitButton() {
        dismiss(animated: true,completion: nil)
    }
    
    @objc func touchDisLike() {
        
    }
    
    @objc func touchSuperLike() {
        
    }
    
    @objc func touchLike() {
        
    }
    
}

// MARK: - UICollectionViewDelegate

extension ProfileController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension ProfileController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userModel.imageURLS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellIdentifer, for: indexPath)
        if indexPath.row == 0 {
            cell.backgroundColor = .red
        }
        else { cell.backgroundColor = .blue }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

