//
//  MainNavigationController.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//
import UIKit



class MainNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        configureViewControllers()
    }
    
    
    func configureViewControllers() {

        let contacts                = ContactsVC()
        contacts.title              = "Contacts"
        
        let contactInfo             = ContactInfoVC()
        contactInfo.title           = "Contact Info"

        let newContact              = AddNewContactVC()
        newContact.title            = "New Contact"
        

        navigationBar.isTranslucent = false
        viewControllers             =  [contactInfo,newContact,contacts]
        UINavigationBar.appearance().shadowImage  = UIImage()
        UINavigationBar.appearance().barTintColor = .systemGray5

        }

        
    
}
