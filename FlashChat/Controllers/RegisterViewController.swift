//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Игорь Клевжиц on 13.08.2024.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth

enum AuthorizationType: String {
    case register = "Register"
    case logIn = "Log In"
}

class RegisterViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 8
        return element
    }()
    
    private let emailTextField = UITextField(
        placeholder: K.emailName,
        color: UIColor(named: K.BrandColors.blue)
    )
    
    private let passwordTextField = UITextField(
        placeholder: K.passwordName,
        color: .black
    )
    
    private let registerButton = UIButton(titleColor: UIColor(named: K.BrandColors.blue))
    
    // MARK: - Public Properties
    
    var authorizationType: AuthorizationType?
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        switch authorizationType {
        case .register:
            view.backgroundColor = .white
            registerButton.setTitle(K.registerName, for: .normal)
            navigationController?.navigationBar.tintColor = UIColor(named: K.BrandColors.blue)
        case .logIn:
            view.backgroundColor = UIColor(named: K.BrandColors.blue)
            registerButton.setTitle(K.logInName, for: .normal)
            registerButton.setTitleColor(.white, for: .normal)
            navigationController?.navigationBar.tintColor = .white
            
            emailTextField.text = "Klevzhits94@icloud.com"
            passwordTextField.text = "333895"
        default: break
        }
        
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(registerButton)
        
        emailTextField.makeShadow()
        passwordTextField.makeShadow()
        passwordTextField.isSecureTextEntry = true
        
        registerButton.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func buttonsTapped(_ sender: UIButton) {
        if sender.currentTitle == K.logInName {
            guard let email = emailTextField.text,
                  let password = passwordTextField.text else { return }
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    let chatVC = ChatViewController()
                    
                    navigationController?.pushViewController(chatVC, animated: true)
                }
            }
        } else {
            guard let email = emailTextField.text,
                  let password = passwordTextField.text else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    let chatVC = ChatViewController()
                    
                    self.navigationController?.pushViewController(chatVC, animated: true)
                }
            }
        }
    }

}

// MARK: - Setup Constraints

extension RegisterViewController {
    
    private func setupConstraints() {
        
        mainStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalTo(view).inset(36)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalTo(view).inset(36)
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalTo(view).inset(36)
        }
    }
    
}


