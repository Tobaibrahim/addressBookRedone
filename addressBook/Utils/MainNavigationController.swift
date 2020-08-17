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
    
    
    //MARK: - LifeCycle

    
    override func viewDidLoad() {
        configureViewControllers()
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
