//
//  ContactsVC.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import Firebase


class ContactsVC: UIViewController {
    
    //MARK: - Properties
    var numberOfRows: Int!
    
    var contactNameString: String!
    
    
    var Contact: UserData? {
        didSet {
            print("DEBUG: Did set user in contacts")
        }
    }
    
    var contactKey: Contactskeys? {
        didSet {
            print("DEBUG: Did set key in contacts")
            tableView.reloadData()
        }
    }
    
    
    var searchContacts = [String]()
    var issearching    = false
    var isArrayEmpty   = false
        
    
    let searchBar:UISearchBar = {
        let searchBar =  UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor      = .systemGray
        tv.backgroundColor     = .systemGray5
        tv.rowHeight           = 85
        tv.register(ContactsCell.self, forCellReuseIdentifier: ContactsCell.reuseID)
        tv.sectionIndexColor   = .systemGray6
        
        return tv
    }()
    
    
    //MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    //MARK: - Helpers
    func fetchUsers(user:String) {
        UserService.shared.fetchUser(user: user) { (userData) in
            self.Contact = userData
        }
    }
    
    func fetchKeys() {
        UserService.shared.fetchKey { (key) in
            self.contactKey = key
        }
    }
    
    func configureUI() {
        fetchKeys()
        
        view.backgroundColor   = .systemGray5
        let addButton          = UIBarButtonItem(image: SFSymbols.addButton, style: .done, target: self, action:#selector(addButtonPressed))
        addButton.tintColor    = .systemBlue
        navigationItem.rightBarButtonItem  = addButton
        navigationItem.hidesBackButton = true
        
        if isArrayEmpty {
            showEmptyStateView(with: " Tap on the  +  to add a new contact", in: view)
        }
        else {
            view.addSubview(tableView)
            view.addSubview(searchBar)
            
            searchBar.delegate   = self
            searchBar.sizeToFit()
            tableView.frame      = view.frame
            tableView.delegate   = self
            tableView.dataSource = self
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.titleView = searchBar
        }
        
    }
    @objc func addButtonPressed() {
        
        let destVC        = AddNewContactVC()
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
    }
    
    
    deinit {
        print("DEBUG: Contacts WAS DEINIT")
    }
    
}


extension ContactsVC:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: ContactsCell.reuseID) as! ContactsCell
        
        cell.editImageView.image = SFSymbols.icon
        
        if issearching {
            cell.titleLabel.text = searchContacts[indexPath.row]
            // add nickname here too from firebase
        }
            
        else {
            cell.nickNameLabel.text  = Contact?.nickName
            cell.titleLabel.text     = contactKey?.keys[indexPath.row]
            // add this in cell
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let safeContactKey = contactKey?.keys else {return 0}
        
        if issearching {
            return searchContacts.count
        }
        else {
            
            return safeContactKey.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destVC = ContactInfoVC()

        if issearching {
            let path = searchContacts[indexPath.row]
            fetchUsers(user: path)
            destVC.passedOverContactName = path
        }
            
        else {
            let path  = contactKey?.keys[indexPath.row]
            fetchUsers(user: path!)
            destVC.passedOverContactName = path
            
        }
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
        
    }
    
    
    
}



extension ContactsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        issearching = true
        guard let safeContactKey = contactKey?.keys else {return}
        searchContacts = safeContactKey.filter({$0.prefix(searchText.count) == searchText})
        tableView.reloadData()
        
    }
}
