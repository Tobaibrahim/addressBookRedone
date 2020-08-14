//
//  ContactsVC.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController {
    
    //MARK: Properties
    var searchContacts = [String]()
    var issearching    = false
    var isArrayEmpty   = false
    
    let names = ["Toba","Tas","Ashley","Marcus","Tom","Peter"]
    
    
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
    
    
    //MARK: Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: Helpers
    
    func configureUI() {
        
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
    
    @objc func searchButtonPressed() {
        
        
    }
    
    
    
}


extension ContactsVC:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: ContactsCell.reuseID) as! ContactsCell
        
        cell.editImageView.image = SFSymbols.icon
        cell.nickNameLabel.text = "NickName"
        
        if issearching {
            cell.titleLabel.text = searchContacts[indexPath.row]
            // add nickname here too from firebase
        }
            
        else {
            
            cell.titleLabel.text = names[indexPath.row]
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if issearching {
            return searchContacts.count
        }
        else {
            return names.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let destVC        = ContactInfoVC()
            let navController = UINavigationController(rootViewController: destVC)
            present(navController, animated: true)
        }
    }
    
    
}



extension ContactsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        issearching = true
        searchContacts = names.filter({$0.prefix(searchText.count) == searchText})
        tableView.reloadData()
        
    }
}
