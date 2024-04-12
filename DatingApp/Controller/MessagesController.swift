//
//  MessagesController.swift
//  DatingApp
//
//  Created by muhammed dursun on 11.04.2024.
//

import UIKit

private let cellIdentifier = "cell"

class MessagesController : UITableViewController{
    
    // MARK: - Properties
    
    private let userModel  : UserModel
    private let upperHeaderView = MatchHeaderView()
    
    // MARK: - Lifecycle
    
    init(userModel:UserModel){
        self.userModel = userModel
        super.init(style: .plain)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureTableView()
        configureNavigationBar()
        fetchMatches()
    }
    
    // MARK: - Assistants
    
    func configureTableView(){
        tableView.rowHeight = 84
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        upperHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 190)
        tableView.tableHeaderView = upperHeaderView
    }
    
    func configureNavigationBar() {
        let leftButton =  UIImageView()
        leftButton.setDimensions(height: 25, width: 25)
        leftButton.isUserInteractionEnabled = true
        leftButton.image = UIImage(named: "app_icon")?.withRenderingMode(.alwaysTemplate)
        leftButton.tintColor = .lightGray
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchDismiss))
        leftButton.addGestureRecognizer(tap)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let messageIcon = UIImageView(image:UIImage(named: "top_right_messages")!.withRenderingMode(.alwaysTemplate))
        messageIcon.tintColor = .systemPurple
        navigationItem.titleView = messageIcon
        
    }
    
    // MARK: - Actions
    
    @objc func touchDismiss() {
        dismiss(animated: true,completion: nil)
    }
    
    
    // MARK: - Firebase Connection
    
    func fetchMatches(){
        Service.fetchMatches { matchModelValues in
            self.upperHeaderView.matchModelValues = matchModelValues
        }
    }
    
}

// MARK: - UITableViewDataSource

extension MessagesController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
    
    // MARK: UITableViewDelegete
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let normalHeaderLabel = UILabel()
        normalHeaderLabel.text = "Mesajlar"
        normalHeaderLabel.textColor =  #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        normalHeaderLabel.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(normalHeaderLabel)
        normalHeaderLabel.centerY(inView: view,leftAnchor: view.leftAnchor,paddingLeft: 10)
        return view
    }
    
}



