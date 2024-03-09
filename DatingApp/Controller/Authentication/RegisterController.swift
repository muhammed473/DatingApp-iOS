//
//  RegisterController.swift
//  DatingApp
//
//  Created by muhammed dursun on 8.03.2024.
//

import UIKit

class RegisterController: UIViewController{
    
    // MARK: - Properties
    private let photoButton : UIButton = {
       let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(touchSelectPhoto), for: .touchUpInside)
        return button
    }()
    private let emailTextField = TextFieldCustom(placeHolder: "Email")
    private let fullNameTextField = TextFieldCustom(placeHolder: "Full Name")
    private let passwordTextField = TextFieldCustom(placeHolder: "Password", isSecureText: true)
    private let registerButton : ButtonAuthentication = {
        let authButton = ButtonAuthentication(title: "Register", buttonType: .system)
        authButton.addTarget(self, action: #selector(touchRegisterButton), for: .touchUpInside)
        return authButton
    }()
    private let signInButton : UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(string: "Already have an account   "
                                                         ,attributes: [.foregroundColor: UIColor.white,.font : UIFont.systemFont(ofSize: 17)])
        attributedString.append(NSAttributedString(string: "Sign In",attributes: [.foregroundColor: UIColor.white,.font: UIFont.boldSystemFont(ofSize: 18)]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(touchSignInButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Assistant
    
    func configureUI() {
        configureGradientLayer()
        view.addSubview(photoButton)
        photoButton.setDimensions(height: 250, width: 250)
        photoButton.centerX(inView: view)
        photoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 10)
        let stackView = UIStackView(arrangedSubviews: [emailTextField,fullNameTextField,passwordTextField,registerButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        view.addSubview(stackView)
        stackView.anchor(top:photoButton.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 22,paddingLeft: 28,paddingRight: 28)
        view.addSubview(signInButton)
        signInButton.anchor(left:view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 28,paddingRight: 28)
    }
    
    // MARK: - Actions
    
    @objc func touchSelectPhoto() {
        print("Fotoğraf seçme butonuna tıklandı.")
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker,animated: true,completion: nil)
    }
    
    @objc func touchRegisterButton() {
        print("Kaydol butonuna tıklandı.")
    }
    
    @objc func touchSignInButton() {
        print("Giriş yap butonuna tıklandı.")
        navigationController?.popViewController(animated: true) // Register screen closed.
    }
}

// MARK: - ImagePicker

extension RegisterController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        photoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        photoButton.layer.borderColor = UIColor(white: 1, alpha: 0.6).cgColor
        photoButton.layer.cornerRadius = 9
        photoButton.layer.borderWidth = 3.5
        photoButton.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true,completion: nil)
    }
}

