//
//  AddNewContactVC.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

class AddNewContactVC: UIViewController {
    
    //MARK: Properties
    
    
    let imagePicker   = UIImagePickerController()

    // Test
    private lazy var firstNameTextField:ABTextField = {
        let firstName = ABTextField()
        return firstName
    }()
    
    private lazy var nickNameTextField:ABTextField = {
        let firstName = ABTextField()
        return firstName
    }()
    
    private lazy var lastNameTextField:ABTextField = {
        let lastName = ABTextField()
        return lastName
    }()
    
    private lazy var emailTextField:ABTextField = {
        let firstName = ABTextField()
        return firstName
    }()
   
    private lazy var PhoneNumberTextField:ABTextField = {
        let firstName = ABTextField()
        return firstName
    }()
    private lazy var AddressTextField:ABTextField = {
        let firstName = ABTextField()
        
        return firstName
    }()
  

    let titleLabel: ABTitleLabel = {
        let title       = ABTitleLabel(textAlignment: .left, fontsSize: 14)
        title.text      = "Edit"
        title.textColor = .systemBlue
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
        
        
        let PhoneNumberInputView  = ABInputView(textView: PhoneNumberTextField, title: "PhoneNumber")
        let firstNameInputView    = ABInputView(textView: firstNameTextField, title:"First Name")
        let lastNameInputView     = ABInputView(textView: lastNameTextField, title: "Last Name")
        let emailInputView        = ABInputView(textView: emailTextField, title: "Email")
        let nickNameInputView     = ABInputView(textView: nickNameTextField, title: "Nick Name")
        let AddressInputView      = ABInputView(textView: AddressTextField, title: "Address")
        AddressInputView.underLine.isHidden = true

        
        let views = [contactImage,titleLabel,
        separatorLine,firstNameInputView
        ,lastNameInputView,emailInputView,
        PhoneNumberInputView,AddressInputView,nickNameInputView]
        
        for views in views {
            view.addSubview(views)
        }
        
        let saveButton            = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        saveButton.tintColor      = .systemBlue
        
        let backArrowButton       = UIBarButtonItem(image: SFSymbols.backArrow, style: .done, target: self, action:#selector(addButtonPressed))
        backArrowButton.tintColor = .systemBlue
        
        navigationItem.rightBarButtonItem  = saveButton
        navigationItem.leftBarButtonItem   = backArrowButton
 
        
        contactImage.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 70)
        contactImage.setDimensions(width: 96, height: 96)
        titleLabel.centerX(inView: view, topAnchor: contactImage.bottomAnchor, paddingTop: 10)
        separatorLine.centerX(inView: view, topAnchor: titleLabel.bottomAnchor, paddingTop: 25)
        
        firstNameInputView.anchor(top: separatorLine.bottomAnchor, leading: view.leadingAnchor,trailing: view.trailingAnchor, paddingTop: 50, paddingLeft: 10, paddingRight: 10, height: 60)
        
        lastNameInputView.anchor(top: firstNameInputView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingLeft: 10,  paddingRight: 10, height: 60)
        
        emailInputView.anchor(top: lastNameInputView.bottomAnchor, leading: view.leadingAnchor,trailing: view.trailingAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: 60)
        
        nickNameInputView.anchor(top: emailInputView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingLeft: 10,  paddingRight: 10, height: 60)
        
        PhoneNumberInputView.anchor(top: nickNameInputView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: 60)
        
        AddressInputView.anchor(top: PhoneNumberInputView.bottomAnchor, leading: view.leadingAnchor,trailing: view.trailingAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: 60)
        
    }
    
    @objc func addButtonPressed() {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func saveButtonPressed() {
        print("DEBUG: Textfileds saved")
    
        
    }

}


extension AddNewContactVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveButtonPressed()
        return true
    }
    
}
