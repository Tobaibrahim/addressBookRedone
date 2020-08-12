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
    
    let plusButton: UIImage = {
        let image = UIImage(named: "plus")
        return image!
    }()

    
    //MARK: Life Cycle


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    
    
    //MARK: Helpers
    

    
    func configureUI() {
        
        showEmptyStateView(with: " Tap on the  +  to add a new contact", in: view)
        
        
        view.backgroundColor   = .systemGray5
        
        let addButton          = UIBarButtonItem(image: SFSymbols.addButton, style: .done, target: self, action:#selector(addButtonPressed))
        addButton.tintColor    = .systemBlue
        
        let searchButton       = UIBarButtonItem(image: SFSymbols.Search, style: .done, target: self, action:#selector(addButtonPressed))
        searchButton.tintColor = .systemGray
        
        navigationItem.rightBarButtonItem  = addButton
        navigationItem.leftBarButtonItem   = searchButton
        
        
    }

    @objc func addButtonPressed() {
        
        let destVC        = AddNewContactVC()
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
    }

}
