//
//  ContactInfoVC.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

class ContactInfoVC: UIViewController {
    
    
    //MARK: Properties
    
        
    private lazy var firstNameLabelField:ABBodyLabel = {
        let firstName = ABBodyLabel()
        return firstName
    }()
    
    private lazy var lastNameLabelField:ABBodyLabel = {
        let lastName = ABBodyLabel()
        return lastName
    }()
    
    private lazy var emailLabelField:ABBodyLabel = {
        let firstName = ABBodyLabel()
        return firstName
    }()
    private lazy var nickNameLabelField:ABBodyLabel = {
        let firstName = ABBodyLabel()
        return firstName
    }()
    private lazy var PhoneNumberLabelField:ABBodyLabel = {
        let firstName = ABBodyLabel()
        return firstName
    }()
    private lazy var AddressLabelField:ABBodyLabel = {
        let firstName = ABBodyLabel()
        return firstName
    }()
    
    
    let titleLabel: ABTitleLabel = {
        let title       = ABTitleLabel(textAlignment: .left, fontsSize: 18)
        title.text      = "Contact"
        title.textColor = .label
        return title
    }()
    
    let nickNameLabel: ABBodyLabel = {
        let title       = ABBodyLabel(textAlignment: .center, fontsSize: 13)
        title.text      = "\"NickName\""
        title.setDimensions(width: 120, height: 20)
        return title
    }()
    
    
    
    let contactImage:ABImageView = {
        let image       = ABImageView(frame: .zero)
        image.image     = SFSymbols.icon
        image.layer.cornerRadius = 17
        image.tintColor = .systemGray
        return image
    }()
    
    let separatorLine:UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray2
        line.setDimensions(width: 360, height: 1)
        line.alpha = 4
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: Helpers
    
    
    func configureUI() {
        
        view.backgroundColor   = .systemGray5
        
        let firstNameDisplayView    = ABDisplayView(displayView: firstNameLabelField, title: "First Name")
        let lastNameDisplayView     = ABDisplayView(displayView: lastNameLabelField, title: "Last Name")
        let emailDisplayView        = ABDisplayView(displayView: emailLabelField, title: "Email")
        let nickNameDisplayView     = ABDisplayView(displayView: nickNameLabelField, title: "Nick Name")
        let PhoneNumberDisplayView  = ABDisplayView(displayView: PhoneNumberLabelField, title: "Phone")
        let AddressDisplayView      = ABDisplayView(displayView: AddressLabelField, title: "Address")
        AddressDisplayView.underLine.isHidden = true
        
        
        let views = [contactImage,titleLabel,
                     separatorLine,firstNameDisplayView
            ,lastNameDisplayView,emailDisplayView,
             PhoneNumberDisplayView,AddressDisplayView,nickNameLabel,nickNameDisplayView]
        
        for views in views {
            view.addSubview(views)
        }
        
        let EditButton            = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButtonPressed))
        EditButton.tintColor      = .systemBlue
        
        let backArrowButton       = UIBarButtonItem(image: SFSymbols.backArrow, style: .done, target: self, action:#selector(addButtonPressed))
        backArrowButton.tintColor = .systemBlue
        
        navigationItem.rightBarButtonItem  = EditButton
        navigationItem.leftBarButtonItem   = backArrowButton
        
        
        contactImage.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 70)
        contactImage.setDimensions(width: 96, height: 96)
        titleLabel.centerX(inView: view, topAnchor: contactImage.bottomAnchor, paddingTop: 10)
        separatorLine.centerX(inView: view, topAnchor: titleLabel.bottomAnchor, paddingTop: 25)
        nickNameLabel.centerX(inView: view, topAnchor: titleLabel.bottomAnchor, paddingTop: 1)
        
        firstNameLabelField.text = "Toba"
        lastNameLabelField.text = "Ibrahim"
        emailLabelField.text    = "Toba.I@hotmail.com"
        nickNameLabelField.text  = "Tobaaaaa"
        PhoneNumberLabelField.text = "07743023250"
        AddressLabelField.text     = "4 acle gardens, bulwell, Nottingham,NG6 8NY"
        
        
        firstNameDisplayView.centerX(inView: view, topAnchor: separatorLine.bottomAnchor, paddingTop: 30)
        firstNameDisplayView.anchor(leading:view.leadingAnchor,paddingLeft: 10,height: 40)
        lastNameDisplayView.centerX(inView: view, topAnchor: firstNameDisplayView.bottomAnchor, paddingTop: 30)
        lastNameDisplayView.anchor(leading:view.leadingAnchor,paddingLeft: 10,height: 40)
        emailDisplayView.centerX(inView: view, topAnchor: lastNameDisplayView.bottomAnchor, paddingTop: 30)
        emailDisplayView.anchor(leading:view.leadingAnchor,paddingLeft: 10,height: 40)
        PhoneNumberDisplayView.centerX(inView: view, topAnchor: emailDisplayView.bottomAnchor, paddingTop: 30)
        PhoneNumberDisplayView.anchor(leading:view.leadingAnchor,paddingLeft: 10,height: 40)
        nickNameDisplayView.centerX(inView: view, topAnchor: PhoneNumberDisplayView.bottomAnchor, paddingTop: 30)
        nickNameDisplayView.anchor(leading:view.leadingAnchor,paddingLeft: 10,height: 40)
        AddressDisplayView.centerX(inView: view, topAnchor: nickNameDisplayView.bottomAnchor, paddingTop: 30)
        AddressDisplayView.anchor(leading:view.leadingAnchor,paddingLeft: 10,height: 40)

        
    }
    
    
    
    
    @objc func addButtonPressed() {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func editButtonPressed() {
        print("DEBUG: Textfileds saved")
        
//        print("DEBUG:TEXTFIELD NAME = \(String(describing: firstNameTextField.text))")
        
        
    }
    
}


extension ContactInfoVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        editButtonPressed()
        return true
    }
    
}
