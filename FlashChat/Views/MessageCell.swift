//
//  MessageCell.swift
//  FlashChat
//
//  Created by Игорь Клевжиц on 14.08.2024.
//

import UIKit

class MessageCell: UITableViewCell {
    
    // MARK: - Elements
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 20
        element.distribution = .fill
        element.contentMode = .scaleToFill
        element.alignment = .bottom
        return element
    }()
    
    private lazy var leftImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: K.youAvatar)
        element.clipsToBounds = true
        element.layer.cornerRadius = 20
        return element
    }()
    
    private lazy var rightImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: K.meAvatar)
        element.clipsToBounds = true
        element.layer.cornerRadius = 20
        return element
    }()
    
    private lazy var messageView: UIView = {
        let element = UIView()
        return element
    }()
    
    private lazy var messageLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        return element
    }()
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        messageView.layoutIfNeeded()
        messageView.layer.cornerRadius = messageView.frame.size.height / 4
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Properties
    
    func configure(with model: Message, sender: Sender) {
        switch sender {
        case .me:
            leftImageView.isHidden = true
            rightImageView.isHidden = false
            messageView.backgroundColor = UIColor(named: K.BrandColors.purple)
            messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        case .you:
            leftImageView.isHidden = false
            rightImageView.isHidden = true
            messageView.backgroundColor = UIColor(named: K.BrandColors.blue)
            messageLabel.textColor = UIColor(named: K.BrandColors.lighBlue)
        }
        
        messageLabel.text = model.body
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(leftImageView)
        mainStackView.addArrangedSubview(messageView)
        messageView.addSubview(messageLabel)
        mainStackView.addArrangedSubview(rightImageView)
    }
}

// MARK: - Setup Constraints

extension MessageCell {
    
    private func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        leftImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
    }
    
}
