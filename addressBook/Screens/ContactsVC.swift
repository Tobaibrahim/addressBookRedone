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
        }
    }
    
    var contactKey: Contactskeys? {
        didSet {
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
        createObservers()
        let addButton          = UIBarButtonItem(image: SFSymbols.addButton, style: .done, target: self, action:#selector(addButtonPressed))
        addButton.tintColor    = .systemBlue
        view.backgroundColor   = .systemGray5
        navigationItem.rightBarButtonItem  = addButton
        navigationItem.hidesBackButton = true
        
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
       
        searchBar.delegate     = self
        searchBar.sizeToFit()
        tableView.frame        = view.bounds
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            if self.nameArray.isEmpty {
                self.navigationController?.navigationBar.prefersLargeTitles = false
                self.view.showEmptyStateView(with: "Tap on the  +  to add a new contact", in: self.view)
                self.searchBar.isHidden = true
                self.tableView.isHidden = true
            }
            else {
                DispatchQueue.main.async {
                    self.view.removeEmptyStateView()
                    self.navigationController?.navigationBar.prefersLargeTitles = true
                    self.searchBar.isHidden = false
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
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
       
        if self.issearching {cell.titleLabel.text = self.searchContacts[indexPath.row]
            
        }
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

        let path = contactKey?.keys[indexPath.row]
        reloadTableView()

        if issearching {
            let path = searchContacts[indexPath.row]
            searchContacts.remove(at: indexPath.row)
            nameArray.remove(at: indexPath.row)
            AuthService.shared.deleteContact(user: path)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
            
        else {
            nameArray.remove(at: indexPath.row)
            AuthService.shared.deleteContact(user: path!)
            tableView.deleteRows(at: [indexPath], with: .left)
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
        searchBar.showsCancelButton = true
        searchContacts = nameArray.filter({$0.prefix(searchText.count) == searchText})
            tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false

    }


}

