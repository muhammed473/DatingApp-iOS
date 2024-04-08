//
//  RegisterController.swift
//  DatingApp
//
//  Created by muhammed dursun on 8.03.2024.
//

import UIKit

class RegisterController: UIViewController{
    
    // MARK: - Properties
    weak var delegate : AuthenticationDelegate?
    private let photoButton : UIButton = {
       let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(touchSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
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
    private var registerViewModel = RegisterViewModel()
    private var profileImage : UIImage?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldsObserver()
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
    
    func configureTextFieldsObserver() {
        emailTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    func checkForm(){
        if registerViewModel.isFormValid {
            registerButton.isEnabled = true
            registerButton.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        }else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        }
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
        guard let email = emailTextField.text else {return}
        guard let fullName = fullNameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let profileImage = self.profileImage else {return}
        let authCredentialsModelValues = AuthCredentialsModel(email: email, fullName: fullName,
                                                              password: password, profileImage: profileImage)
        
        AuthenticationService.registerUser(authCredentialsModel: authCredentialsModelValues) { error in
            if let error = error {
                print("Kullanıcı kaydedilirken hata oluştu : \(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationComplete()
        }
    }
    
    @objc func touchSignInButton() {
        print("Giriş yap butonuna tıklandı.")
        navigationController?.popViewController(animated: true) // Register screen closed.
    }
    
    @objc func textFieldsDidChange (currentTextField : UITextField ) {
      //  print("Metin  : \(currentTextField.text!)")
        if currentTextField == emailTextField {
            registerViewModel.email = currentTextField.text
        }else if currentTextField == fullNameTextField{
            registerViewModel.fullName = currentTextField.text
        }else{
            registerViewModel.password = currentTextField.text
        }
        print("Form geçerli mi : \(registerViewModel.isFormValid)")
        checkForm()
    }
}

// MARK: - ImagePicker

extension RegisterController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        self.profileImage = image
        photoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        photoButton.layer.borderColor = UIColor(white: 1, alpha: 0.6).cgColor
        photoButton.layer.cornerRadius = 9
        photoButton.layer.borderWidth = 3.5
        photoButton.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true,completion: nil)
    }
}

