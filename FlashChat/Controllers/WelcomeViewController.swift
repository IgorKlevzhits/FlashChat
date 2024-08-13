//
//  ViewController.swift
//  FlashChat
//
//  Created by Игорь Клевжиц on 13.08.2024.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.textColor = UIColor(named: K.BrandColors.blue)
        element.font = .systemFont(ofSize: 50, weight: .black)
        return element
    }()
    
    var registerButton = UIButton(
        titleColor: UIColor(named: K.BrandColors.blue),
        backgroundColor: UIColor(named: K.BrandColors.lighBlue)
    )
    
    var logInButton = UIButton(
        titleColor: .white,
        backgroundColor: UIColor(named: K.BrandColors.blue)
    )
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
        animationText()
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(registerButton)
        view.addSubview(logInButton)
        
        registerButton.setTitle(K.registerName, for: .normal)
        logInButton.setTitle(K.logInName, for: .normal)
        
        registerButton.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
    }
    
    private func animationText() {
        titleLabel.text = ""
        let titleText = K.appName
        
        for letter in titleText.enumerated() {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(letter.offset), repeats: false) { timer in
                self.titleLabel.text! += String(letter.element)
            }
        }
    }
    
    @objc private func buttonsTapped(_ sender: UIButton) {
        let nextVC = RegisterViewController()
        
        if sender.currentTitle == K.registerName {
            nextVC.authorizationType = .register
        } else if sender.currentTitle == K.logInName {
            nextVC.authorizationType = .logIn
        }
        
        navigationController?.pushViewController(nextVC, animated: true)
    }

}

// MARK: - Setup Constraints

extension WelcomeViewController {
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        logInButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(K.Size.buttonSize)
        }
        
        registerButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(logInButton.snp.top).offset(-K.Size.buttonOffset)
            make.height.equalTo(K.Size.buttonSize)
        }
    }
    
}


