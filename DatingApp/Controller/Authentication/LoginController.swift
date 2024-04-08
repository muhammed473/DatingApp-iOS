//
//  LoginController.swift
//  DatingApp
//
//  Created by muhammed dursun on 8.03.2024.
//

import UIKit

protocol AuthenticationDelegate : class {
    func authenticationComplete()
}

class LoginController : UIViewController {
    
    // MARK: - Properties
    weak var delegate : AuthenticationDelegate?
    private let symbolImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "app_icon")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        return imageView
    }()
    private let emailTextField = TextFieldCustom(placeHolder: "Email")
    private let passwordTextField = TextFieldCustom(placeHolder: "Password", isSecureText: true)
    private let authButton : ButtonAuthentication = {
        let authButton = ButtonAuthentication(title: "Log In", buttonType: .system)
        authButton.addTarget(self, action: #selector(touchLogInButton), for: .touchUpInside)
        return authButton
    }()
    private let signUpButton : UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(string: "Don't you have an account?   "
                                                         ,attributes: [.foregroundColor: UIColor.white,.font : UIFont.systemFont(ofSize: 17)])
        attributedString.append(NSAttributedString(string: "Sign Up",attributes: [.foregroundColor: UIColor.white,.font: UIFont.boldSystemFont(ofSize: 18)]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(touchRegisterButton), for: .touchUpInside)
        return button
    }()
    private var loginViewModel = LoginViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldsObserver()
        configureUI()
    }
    
    
    // MARK: - Assistant
    
    func configureUI(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        view.addSubview(symbolImageView)
        symbolImageView.centerX(inView: view)
        symbolImageView.setDimensions(height: 95, width: 95)
        symbolImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 26)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,authButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        view.addSubview(stackView)
        stackView.anchor(top:symbolImageView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 22,paddingLeft: 28,paddingRight: 28)
        view.addSubview(signUpButton)
        signUpButton.anchor(left:view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 28,paddingRight: 28)
    }
    
    func configureTextFieldsObserver() {
        emailTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    func checkForm(){
        if loginViewModel.isFormValid {
            authButton.isEnabled = true
            authButton.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        }else {
            authButton.isEnabled = false
            authButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        }
    }
    
    // MARK: - Actions
    
    @objc func touchLogInButton() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        AuthenticationService.loginUser(email: email, password: password) { result,error in
            if let error = error {
                print("Kullanıcı kaydedilirken hata oluştu : \(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationComplete()
        }
    }
    
    @objc func touchRegisterButton() {
        let controller = RegisterController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textFieldsDidChange (currentTextField : UITextField ) {
      //  print("Metin  : \(currentTextField.text!)")
        if currentTextField == emailTextField {
            loginViewModel.email = currentTextField.text
        }else{
            loginViewModel.password = currentTextField.text
        }
        print("Form geçerli mi : \(loginViewModel.isFormValid)")
        checkForm()
    }
    
}
