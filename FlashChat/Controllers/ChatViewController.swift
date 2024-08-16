//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Игорь Клевжиц on 13.08.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(named: K.BrandColors.purple)
        return element
    }()
    
    private let tableView = UITableView()
    
    private lazy var messageTextField: UITextField = {
        let element = UITextField()
        element.backgroundColor = .white
        element.borderStyle = .roundedRect
        element.placeholder = K.enterMessagePlaceholder
        element.textColor = UIColor(named: K.BrandColors.purple)
        element.tintColor = UIColor(named: K.BrandColors.purple)
        return element
    }()
    
    private lazy var enterButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: K.enterButtonImageName), for: .normal)
        element.tintColor = .white
        return element
    }()
    
    private lazy var logOut = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutPressed))
    
    // MARK: - Private Properties
    
    private var messages: [Message] = []
    private let db = Firestore.firestore()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setViews()
        setupConstraints()
        loadMessages()
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        view.backgroundColor = UIColor(named: K.BrandColors.purple)
        title = K.appName
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.purple)
        
        logOut.tintColor = .red
        navigationItem.rightBarButtonItem = logOut
        
        tableView.backgroundColor = .white
        tableView.register(MessageCell.self, forCellReuseIdentifier: K.cellIdentifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
        view.addSubview(containerView)
        containerView.addSubview(messageTextField)
        containerView.addSubview(enterButton)
        
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Set Delegates
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { [weak self] querySnapshot, error in
                
                guard let self = self else { return }
                self.messages = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    guard let snapshotDocuments = querySnapshot?.documents else { return }
                    
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        guard let sender = data[K.FStore.senderField] as? String,
                              let messageBody = data[K.FStore.bodyField] as? String else { return }
                        self.messages.append(Message(sender: sender, body: messageBody))
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                }
            }
    }
    
    // MARK: - Actions
    
    @objc private func logOutPressed() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error singing out $@", signOutError)
        }
    }
    
    @objc private func enterButtonPressed() {
        guard let messageBody = messageTextField.text,
              let messageSender = Auth.auth().currentUser?.email else { return }
        
        db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.senderField: messageSender,
            K.FStore.bodyField: messageBody,
            K.FStore.dateField: Date().timeIntervalSince1970
        ]) { error in
            if let e = error {
                print("Ther was an issue saving data to firestore \(e)")
            } else {
                print("Successfully sved data")
                DispatchQueue.main.async {
                    self.messageTextField.text = ""
                }
            }
        }
        view.endEditing(true)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as? MessageCell else { fatalError() }
        
        let message = messages[indexPath.row]
        
        let sender: Sender = message.sender == Auth.auth().currentUser?.email ? .me : .you
        cell.configure(with: message, sender: sender)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}

// MARK: - Setup Constraints

extension ChatViewController {
    
    private func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(tableView.snp.bottom)
            make.height.equalTo(60)
        }
        
        messageTextField.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(messageTextField.snp.trailing).offset(20)
            make.height.width.equalTo(40)
        }
    }
}
