//
//  MainNavigationController.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//
import UIKit



class MainNavigationController: UINavigationController {
    
    
    //MARK: - properties
    
    var Contact: UserData? {
        didSet {
            print("DEBUG: Did set user in main navigation controller")
            
            guard let nav = viewControllers.first as? UINavigationController else {return}
            guard let contactsVC = nav.viewControllers.first as? ContactsVC else {return}
            
            contactsVC.Contact = self.Contact
        }
    }
    
    
    
    //MARK: - LifeCycle

    
    override func viewDidLoad() {
        configureViewControllers()
    }
    
    
    func fetchUsers() {
        UserService.shared.fetchUser(user: "lionel Messi") { (userData) in
            self.Contact = userData
        }
    }
    
    
    
    //MARK: - Helpers

    
    func configureViewControllers() {
//        fetchUsers()
        
        let contacts                = ContactsVC()
        contacts.title              = "Contacts"
        let contactInfo             = ContactInfoVC()
        contactInfo.title           = "Contact Info"
        let newContact              = AddNewContactVC()
        newContact.title            = "New Contact"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray5
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemGray5]
        navigationBar.isTranslucent = false
        viewControllers             =  [contactInfo,newContact,contacts]
        UINavigationBar.appearance().shadowImage  = UIImage()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
       
        }

        
    
}
