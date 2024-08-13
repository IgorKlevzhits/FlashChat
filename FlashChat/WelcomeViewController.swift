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
    }
    
    @objc private func buttonsTapped(_ sender: UIButton) {
        
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(registerButton)
        view.addSubview(logInButton)
        
        titleLabel.text = K.appName
        registerButton.setTitle(K.registerName, for: .normal)
        logInButton.setTitle(K.logInName, for: .normal)
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

extension UIButton {
    convenience init(titleColor: UIColor?, backgroundColor: UIColor? = .clear) {
        self.init(type: .system)
        self.titleLabel?.font = .systemFont(ofSize: 30)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
    }
}
