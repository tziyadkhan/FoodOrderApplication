//
//  RegistrationPageController.swift
//  FoodOrderApplication
//
//  Created by Ziyadkhan on 11.03.24.
//

import UIKit
import SnapKit
import RealmSwift

class RegistrationPageController: UIViewController {
    
    lazy var logoImageView: UIImageView = {
        return ReusableImageView.reusableImage(imageName: "MainLogo", contentMode: .scaleAspectFill)
    }()
    
    lazy var signupLabel: UILabel = {
        let label =  ReusableLabel.reusableLabel(fontName: "Times New Roman Bold", fontSize: 32, numOfLines: 0)
        label.text = "Sign up"
        label.textColor = .white
    
        return label
    }()
    
    lazy var fullnameTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Fullname",
                                                   keyboardType: .default,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var fullnameView: UIView = {
        return ReusableView.reusableView(color: .white,
                                         borderWidth: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    lazy var usernameTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Email",
                                                   keyboardType: .emailAddress,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var usernameView: UIView = {
        return ReusableView.reusableView(color: .white,
                                         borderWidth: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    
    lazy var phoneTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Phone number",
                                                   keyboardType: .numberPad,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var phoneView: UIView = {
        return ReusableView.reusableView(color: .white,
                                         borderWidth: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    lazy var passwordTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Password",
                                                   keyboardType: .default,
                                                   isSecureTextEntry: true,
                                                   borderStyle: .none)
    }()
    
    lazy var passwordView: UIView = {
        return ReusableView.reusableView(color: .white,
                                         borderWidth: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    lazy var registerButton: UIButton = {
        return ReusableButton.reusableButton(title: "Sign up",
                                             titleColour: .white,
                                             fontName: "Times New Roman Bold",
                                             size: 20,
                                             backgroundColour: .button,
                                             target: self,
                                             action: #selector(registerButtonTapped),
                                             controlEvent: .touchUpInside,
                                             cornerRadius: 16)
    }()
    
    
    
    var coordinator: MainCoordinator?
    let helper = Database()
    let emailSaved = UserDefaults.standard.string(forKey: "enteredEmail")
    var user = [User]()
    var tempUser = User()
    var onLogin: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        user = helper.fetchFromDB()
        if let index = user.firstIndex(where: {$0.email == emailSaved}) { //her userin individual akkauntu ile girmesi ucundu
            let userFetch = user[index]
            tempUser = userFetch
        }
    }
}

//MARK: Functions
extension RegistrationPageController {
    
    fileprivate func configUI() {
        view.backgroundColor = .mainBG
        view.addSubview(logoImageView)
        view.addSubview(signupLabel)
        view.addSubview(fullnameView)
        view.addSubview(fullnameTextField)
        view.addSubview(usernameView)
        view.addSubview(usernameTextField)
        view.addSubview(phoneView)
        view.addSubview(phoneTextField)
        view.addSubview(passwordView)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
    }
    
    fileprivate func configConstraint() {
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(105)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(330)
        }
        
        signupLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).inset(-32)
            make.centerX.equalTo(logoImageView)
        }
        fullnameView.snp.makeConstraints { make in
            make.top.equalTo(signupLabel.snp.bottom).inset(-32)
            make.centerX.equalTo(signupLabel)
        }
        
        fullnameTextField.snp.makeConstraints { make in
            make.left.equalTo(fullnameView).inset(8)
            make.center.equalTo(fullnameView)
        }
        
        usernameView.snp.makeConstraints { make in
            make.top.equalTo(fullnameView.snp.bottom).inset(-8)
            make.centerX.equalTo(fullnameView)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.left.equalTo(usernameView).inset(8)
            make.center.equalTo(usernameView)
        }
        
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(usernameView.snp.bottom).inset(-8)
            make.centerX.equalTo(usernameView)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.left.equalTo(phoneView).inset(8)
            make.center.equalTo(phoneView)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom).inset(-8)
            make.centerX.equalTo(phoneView)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(passwordView).inset(8)
            make.center.equalTo(passwordView)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).inset(-12)
            make.centerX.equalTo(passwordView)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
    }
    
    @objc fileprivate func registerButtonTapped() {
        if let regUsername = usernameTextField.text,
           let regFullname = fullnameTextField.text,
           let regPhoneNumber = phoneTextField.text,
           let regPassword = passwordTextField.text,
           !regUsername.isEmpty,
           !regFullname.isEmpty,
           !regPhoneNumber.isEmpty,
           !regPassword.isEmpty {
            
            if regUsername != tempUser.email {
                let user = User()
                user.fullName = regFullname
                user.email = regUsername
                user.password = regPassword
                user.phoneNumber = regPhoneNumber
                user.purchase = Purchase()
                
                onLogin?(usernameTextField.text ?? "", passwordTextField.text ?? "")
                helper.saveToDB(user: user)
                navigationController?.popViewController(animated: true)
            } else {
                AlertView.showAlert(view: self, title: "Failed", message: "The user already exist!")
            }
            
        } else {
            AlertView.showAlert(view: self, title: "Failed", message: "Please enter the correct details for registration")
        }
    }
}
