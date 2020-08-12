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
    let imagePicker     = UIImagePickerController()

    // Test
    let firstNameTextField   = ABTextField()
    let lastNameTextField    = ABTextField()
    let emailTextField       = ABTextField()
    let nickNameTextField    = ABTextField()
    let PhoneNumberTextField = ABTextField()
    let AddressTextField     = ABTextField()

    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor      = .systemGray
        tv.backgroundColor     = .systemGray5
        tv.rowHeight           = 80
        tv.register(ContactsAddCell.self, forCellReuseIdentifier: ContactsAddCell.reuseID)
        tv.sectionIndexColor   = .systemGray6
        return tv
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
        line.backgroundColor = .systemGray
        line.setDimensions(width: 360, height: 1)
        line.alpha = 4
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let Container:UIView = {
        let container = UIView()
        container.backgroundColor = .blue
        container.translatesAutoresizingMaskIntoConstraints = false
        container.setDimensions(width: 375, height: 507)
        return container
    }()
    
    
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    

    
    //MARK: Helpers
    
    func configureTableView () {
        Container.addSubview(tableView)
        tableView.frame      = view.frame
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    
    
    func configureUI() {
        
        view.backgroundColor      = .systemGray5
        
        let views = [firstNameTextField,
        lastNameTextField,emailTextField,
        nickNameTextField,PhoneNumberTextField,
        AddressTextField,contactImage,titleLabel,
        Container,separatorLine]
        
        for views in views {
            view.addSubview(views)
        }
        
//        firstNameTextField.centerX(inView: view, topAnchor: titleLabel.bottomAnchor, paddingTop: 10)
//        firstNameTextField.setDimensions(width: 150, height: 20)
//        firstNameTextField.backgroundColor = .magenta
//        
//        
//        //        textInput.anchor(top: titleLabel.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 6, paddingLeft: 10, paddingRight: 50, width: 150, height: 20)
        
        contactImage.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 70)
        contactImage.setDimensions(width: 96, height: 96)
        titleLabel.centerX(inView: view, topAnchor: contactImage.bottomAnchor, paddingTop: 10)
        Container.centerX(inView: view, topAnchor: contactImage.bottomAnchor, paddingTop: 60)
        separatorLine.centerX(inView: view, topAnchor: titleLabel.bottomAnchor, paddingTop: 25)
                    

        let saveButton            = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        saveButton.tintColor      = .systemBlue
        
        let backArrowButton       = UIBarButtonItem(image: SFSymbols.backArrow, style: .done, target: self, action:#selector(addButtonPressed))
        backArrowButton.tintColor = .systemBlue
        
        navigationItem.rightBarButtonItem  = saveButton
        navigationItem.leftBarButtonItem   = backArrowButton
        
        
    }
    
    @objc func addButtonPressed() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func saveButtonPressed() {
        print("DEBUG: Textfileds saved")
        dismiss(animated: true, completion: nil)
        
    }
    
    func getText(text:String) {
        print("DEBUG: TEXT = \(text)")
    }
}



extension AddNewContactVC:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: ContactsAddCell.reuseID) as! ContactsAddCell
        switch indexPath.row {
            
        case 0:
            cell.titleLabel.text = "First Name"
        case 1:
            cell.titleLabel.text = "Last Name"
        case 2:
            cell.titleLabel.text = "Email"
        case 3:
            cell.titleLabel.text = "Nick Name"
        case 4:
            cell.titleLabel.text = "Phone Number"
        case 5:
            cell.titleLabel.text = "Address"
            
        default:
            break
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  6
    }

    
}

extension AddNewContactVC:UITextFieldDelegate {
    
}
