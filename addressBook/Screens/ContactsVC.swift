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
    
    var contactNameString: String!
    var imageArray       = [String]()
    var nameArray        = [String]()
    var searchContacts   = [String]()
    var issearching      = false
    
    
    
    var contact: UserData? {
        didSet {
            print("DEBUG: Did set user in contacts")
        }
    }
    
    var contactKey: Contactskeys? {
        didSet {
            print("DEBUG: Did set key in contacts")
            nameArray.append(contentsOf: contactKey!.keys)
        }
    }
    
    
    
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
    
    override func loadView() {
        super.loadView()
    }
    
    
    
    //MARK: - Helpers
    func fetchUsers(user:String) {
        UserService.shared.fetchUser(user: user) { (userData) in
            self.contact = userData
        }
    }
    
    func fetchKeys() {
        UserService.shared.fetchKey { (key) in
            self.contactKey = key
        }
    }
    
    func configureUI() {
        
        fetchKeys()
        
        let addButton          = UIBarButtonItem(image: SFSymbols.addButton, style: .done, target: self, action:#selector(addButtonPressed))
        
        addButton.tintColor    = .systemBlue
        view.backgroundColor   = .systemGray5
        navigationItem.rightBarButtonItem  = addButton
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true

        searchBar.delegate     = self
        searchBar.sizeToFit()
        tableView.frame        = view.frame
        tableView.delegate     = self
        tableView.dataSource   = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            if self.nameArray.isEmpty {
                self.showEmptyStateView(with: " Tap on the  +  to add a new contact", in: self.view)
            }
            else {
                self.view.addSubview(self.tableView)
                self.view.addSubview(self.searchBar)
                self.navigationItem.titleView = self.searchBar
            }
        }
        
    }
    
    @objc func addButtonPressed() {
        let destVC           = AddNewContactVC()
        let navController    = UINavigationController(rootViewController: destVC)
        destVC.inEditingMode = false
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
        let path = contactKey?.keys[indexPath.row]
        
        UserService.shared.fetchImage(user: path!) { (value) in
            self.imageArray.append( value)
            cell.editImageView.downloadImage(from: self.imageArray[indexPath.row])
        }
        
        if self.issearching {cell.titleLabel.text = self.searchContacts[indexPath.row]}
        else {cell.titleLabel.text = nameArray[indexPath.row]}
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if issearching {
            return searchContacts.count
        }
        return nameArray.count
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else {return}
        nameArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        let path = contactKey?.keys[indexPath.row]
        AuthService.shared.deleteContact(user: path!)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destVC = ContactInfoVC()
        if issearching {
            let path = searchContacts[indexPath.row]
            fetchUsers(user: path)
            destVC.passedOverContactName = path
        }
        else {
            let path  = nameArray[indexPath.row]
            fetchUsers(user: path)
            destVC.passedOverContactName = path
        }
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}

extension ContactsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        issearching = true
        searchContacts = nameArray.filter({$0.prefix(searchText.count) == searchText})
        tableView.reloadData()
        
    }
}
