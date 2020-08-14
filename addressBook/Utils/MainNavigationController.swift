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
        
        
        
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .systemGray5
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemGray5]
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemGray5]
        
        
        
        
        navigationBar.isTranslucent = false
        viewControllers             =  [contactInfo,newContact,contacts]
        UINavigationBar.appearance().shadowImage  = UIImage()
//        UINavigationBar.appearance().barTintColor = .systemGray5
//        UINavigationBar.appearance().backgroundColor = .systemGray5
//        UINavigationBar.appearance().tintColor = .systemGray5
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
       
        }

        
    
}
