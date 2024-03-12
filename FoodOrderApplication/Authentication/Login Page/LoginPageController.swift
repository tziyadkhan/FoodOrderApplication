//
//  LoginPageController.swift
//  FoodOrderApplication
//
//  Created by Ziyadkhan on 11.03.24.
//

import UIKit
import SnapKit

class LoginPageController: UIViewController {
    
    lazy var logoImageView: UIImageView = {
        return ReusableImageView.reusableImage(imageName: "MainLogo", contentMode: .scaleAspectFit)
    }()
    
    lazy var usernameView: UIView = {
        return ReusableView.reusableView(color: .white,
                                         borderWidth: 0.4 ,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 10,
                                         height: 48,
                                         width: 300)
        
    }()
    
    lazy var usernameTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Your username",
                                                   keyboardType: .emailAddress,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var passwordView: UIView = {
        return ReusableView.reusableView(color: .white,
                                         borderWidth: 0.4 ,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 10,
                                         height: 48,
                                         width: 300)
        
    }()
    
    lazy var passwordTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Your password",
                                                   keyboardType: .default,
                                                   isSecureTextEntry: true,
                                                   borderStyle: .none)
    }()
    
    lazy var loginButton: UIButton = {
        return ReusableButton.reusableButton(title: "LOG IN",
                                             titleColour: .white,
                                             fontName: "Times New Roman Bold",
                                             size: 18,
                                             backgroundColour: .button,
                                             target: self,
                                             action: #selector(loginButtonTapped),
                                             controlEvent: .touchUpInside,
                                             cornerRadius: 10)
    }()
    
    lazy var notRegisteredButton: UIButton = {
        let button = UIButton()
        button.setTitle("Not a member? Register here", for: .normal)
        button.addTarget(self, action: #selector(notRegisteredButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        button.titleLabel?.font = UIFont(name: "Times New Roman Bold", size: 16)
        return button
    }()
    
    var coordinator: MainCoordinator?
    let helper = Database()
    var userLoginList = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configConstraints()
        helper.getFilePath()
    }
}

//MARK: Functions
extension LoginPageController  {
    fileprivate func configUI() {
        view.backgroundColor = .mainBG
        view.addSubview(logoImageView)
        view.addSubview(usernameView)
        view.addSubview(passwordView)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(notRegisteredButton)
        
    }
    
    fileprivate func configConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(105)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(330)
        }
        
        usernameView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).inset(-32)
            make.centerX.equalTo(logoImageView)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.left.equalTo(usernameView).inset(8)
            make.center.equalTo(usernameView)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(usernameView.snp.bottom).inset(-8)
            make.centerX.equalTo(usernameView)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(passwordView).inset(8)
            make.center.equalTo(passwordView)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).inset(-12)
            make.centerX.equalTo(passwordView)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
        
        notRegisteredButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).inset(-8)
            make.centerX.equalTo(loginButton)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
    }
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.setValue(true, forKey: "loggedIN") // Setting the flag
            sceneDelegate.homePage(windowScene: scene)
        }
    }
    
    @objc fileprivate func loginButtonTapped() {
        userLoginList = helper.fetchFromDB()
        if let loginEmail = usernameTextField.text,
           let loginPassword = passwordTextField.text,
           !loginEmail.isEmpty,
           !loginPassword.isEmpty {
            if userLoginList.contains(where: {$0.email == loginEmail && $0.password == loginPassword}) {
                UserDefaults.standard.set(loginEmail, forKey: "enteredEmail")
                self.setRoot()
                coordinator?.showHomePage()
            } else {
                AlertView.showAlert(view: self, title: "Failure", message: "Email or password is wrong")
            }
        } else {
            AlertView.showAlert(view: self, title: "Failure", message: "Empty input")
        }
    }
    
    @objc fileprivate func notRegisteredButtonTapped() {
        coordinator?.onLogin = { username, password in
            self.usernameTextField.text = username
            self.passwordTextField.text = password
        }
        coordinator?.showRegistration()
    }
}
