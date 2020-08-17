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
            guard let safeContactKeys = self.contactKey else {return}
            self.nameArray = safeContactKeys.keys
        }
    }
    
    let searchBar:UISearchBar = {
        let searchBar         =  UISearchBar(frame: .zero)
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
        tv.allowsSelection = true
        return tv
    }()
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createObservers()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - Helpers
    
    func createObservers() {
        let name = NSNotification.Name(notificationKeys.reloadTableView)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: name, object: nil)
        print("DEBUG: OBSERVER RELOADED TABLEVIEW")
    }
    
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
        let addButton          = UIBarButtonItem(image: SFSymbols.addButton, style: .done, target: self, action:#selector(addButtonPressed))
        addButton.tintColor    = .systemBlue
        view.backgroundColor   = .systemGray5
        navigationItem.rightBarButtonItem  = addButton
        navigationItem.hidesBackButton = true
        
        searchBar.delegate     = self
        searchBar.sizeToFit()
        tableView.frame        = view.frame
        tableView.delegate     = self
        tableView.dataSource   = self
        view.addSubview(tableView)
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadState()
    }
    
    
    
    @objc func addButtonPressed() {
        let destVC           = AddNewContactVC()
        let navController    = UINavigationController(rootViewController: destVC)
        destVC.inEditingMode = false
        present(navController, animated: true)
    }
    
    
    func loadState() {
        fetchKeys()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            if self.nameArray.isEmpty {
                self.navigationController?.navigationBar.prefersLargeTitles = false
                self.view.showEmptyStateView(with: " Tap on the  +  to add a new contact", in: self.view)
                self.searchBar.isHidden = true
                self.tableView.isHidden = true
            }
            else {
                
                DispatchQueue.main.async {
                    self.view.removeEmptyStateView()
                    self.navigationController?.navigationBar.prefersLargeTitles = true
                    self.searchBar.isHidden = false
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                }
                
            }
        }
        
    }
    
    
    
    
    @objc func reloadTableView() {
        loadState()
    }
    
    deinit {
        print("DEBUG: Contacts WAS DEINIT")
    }
}


extension ContactsVC:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: ContactsCell.reuseID) as! ContactsCell
        cell.editImageView.image = SFSymbols.icon
        let path = nameArray[indexPath.row]
        
        UserService.shared.fetchImage(user: path) { (value) in
            self.imageArray.insert(value, at: indexPath.row)
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
        imageArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        let path = contactKey?.keys[indexPath.row]
        AuthService.shared.deleteContact(user: path!)
        reloadTableView()
        
        
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
