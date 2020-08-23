//
//  ContactInfoVC.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import Firebase

class ContactInfoVC: UIViewController {
    
    //MARK: - Properties
    
    var passedOverContactName: String?
    
    
    
    var contact: UserDataViewModel? {
        didSet {
            print("DEBUG: Did set user in contactInfo")
            configureUI()
        }
    }
    
   
    let firstNameLabelField   = ABBodyLabel()
    let lastNameLabelField    = ABBodyLabel()
    let emailLabelField       = ABBodyLabel()
    let nickNameLabelField    = ABBodyLabel()
    let PhoneNumberLabelField = ABBodyLabel()
    let AddressLabelField     = ABBodyLabel()
    
    let titleLabel: ABTitleLabel = {
        let title       = ABTitleLabel(textAlignment: .left, fontsSize: 18)
        title.text      = "Contact"
        title.textColor = .label
        return title
    }()
    
    let nickNameLabel: ABBodyLabel = {
        let title       = ABBodyLabel(textAlignment: .center, fontsSize: 13)
        title.text      = "\"NickName\""
        title.setDimensions(width: 200, height: 20)
        return title
    }()
    
    let contactImage:ABImageView = {
        let image       = ABImageView(frame: .zero)
        image.image     = SFSymbols.icon
        image.layer.cornerRadius = 96 / 2
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
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints  = false
        sv.showsHorizontalScrollIndicator             = true
        sv.showsVerticalScrollIndicator               = false
        return sv
    }()
    
    let contentView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUsers(user:passedOverContactName ?? "value")
    }
    
    
    //MARK: - Helpers
    
    func fetchUsers(user:String) {
        UserService.shared.fetchUser(user: user) { (userData) in
            self.contact = UserDataViewModel(userData: userData)
        }
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        let contententViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height) // set the scroll view to the
        scrollView.contentSize = contententViewSize
        scrollView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo:scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
    }
    
    func configureUI() {
        configureScrollView()
        view.backgroundColor   = .systemGray5
        
        let height:CGFloat =  40
        let addressHeight:CGFloat = 120
        
        let firstNameDisplayView    = ABDisplayView(displayView: firstNameLabelField, title: "First Name", height: 40)
        let lastNameDisplayView     = ABDisplayView(displayView: lastNameLabelField, title: "Last Name", height: height)
        let emailDisplayView        = ABDisplayView(displayView: emailLabelField, title: "Email", height: height)
        let nickNameDisplayView     = ABDisplayView(displayView: nickNameLabelField, title: "Nick Name", height: height)
        let PhoneNumberDisplayView  = ABDisplayView(displayView: PhoneNumberLabelField, title: "Phone", height: height)
        let AddressDisplayView      = ABDisplayView(displayView: AddressLabelField, title: "Address", height: addressHeight)
        AddressDisplayView.underLine.isHidden = true
        
        guard let safeImageUrl      = contact?.imageURL else {return}
        contactImage.downloadImage(from: safeImageUrl)
        titleLabel.text             = (("\(contact!.firstName) " ) + (contact?.lastName ?? ""))
        nickNameLabel.text          = contact?.nickName
        firstNameLabelField.text    = contact?.firstName
        lastNameLabelField.text     = contact?.lastName
        emailLabelField.text        = contact?.email
        nickNameLabelField.text     = contact?.nickName
        PhoneNumberLabelField.text  = contact?.PhoneNumber
        AddressLabelField.text      = contact?.Address
        
        
        let views = [contactImage,titleLabel,
                     separatorLine,firstNameDisplayView
            ,lastNameDisplayView,emailDisplayView,
             PhoneNumberDisplayView,AddressDisplayView,nickNameLabel,nickNameDisplayView]
        
        for views in views {
            contentView.addSubview(views)
        }
        
        let EditButton                     = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButtonPressed))
        EditButton.tintColor               = .systemBlue
        let backArrowButton                = UIBarButtonItem(image: SFSymbols.backArrow, style: .done, target: self, action:#selector(addButtonPressed))
        backArrowButton.tintColor          = .systemBlue
        
        navigationItem.rightBarButtonItem  = EditButton
        navigationItem.leftBarButtonItem   = backArrowButton
        
        contactImage.centerX(inView: contentView, topAnchor: contentView.topAnchor, paddingTop: 70)
        contactImage.setDimensions(width: 96, height: 96)
        titleLabel.centerX(inView: contentView, topAnchor: contactImage.bottomAnchor, paddingTop: 10)
        separatorLine.centerX(inView: contentView, topAnchor: titleLabel.bottomAnchor, paddingTop: 25)
        nickNameLabel.centerX(inView: contentView, topAnchor: titleLabel.bottomAnchor, paddingTop: 1)
        
        let paddingTop:CGFloat  = 30
        let paddingLeft:CGFloat = 10
        
        firstNameDisplayView.centerX(inView: contentView, topAnchor: separatorLine.bottomAnchor, paddingTop: paddingTop)
        firstNameDisplayView.anchor(leading:contentView.leadingAnchor,paddingLeft: paddingLeft,height: height)
        lastNameDisplayView.centerX(inView: contentView, topAnchor: firstNameDisplayView.bottomAnchor, paddingTop: paddingTop)
        lastNameDisplayView.anchor(leading:contentView.leadingAnchor,paddingLeft: paddingLeft,height: height)
        emailDisplayView.centerX(inView: contentView, topAnchor: lastNameDisplayView.bottomAnchor, paddingTop: paddingTop)
        emailDisplayView.anchor(leading:contentView.leadingAnchor,paddingLeft: paddingLeft,height: height)
        PhoneNumberDisplayView.centerX(inView: contentView, topAnchor: emailDisplayView.bottomAnchor, paddingTop: paddingTop)
        PhoneNumberDisplayView.anchor(leading:contentView.leadingAnchor,paddingLeft: paddingLeft,height: height)
        nickNameDisplayView.centerX(inView: contentView, topAnchor: PhoneNumberDisplayView.bottomAnchor, paddingTop: paddingTop)
        nickNameDisplayView.anchor(leading:contentView.leadingAnchor,paddingLeft: paddingLeft,height: height)
        AddressDisplayView.centerX(inView: contentView, topAnchor: nickNameDisplayView.bottomAnchor, paddingTop: paddingTop)
        AddressDisplayView.anchor(leading:contentView.leadingAnchor,paddingLeft: paddingLeft,height: height)
    }
    
    
    @objc func addButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func editButtonPressed() {        
        let destVC               = AddNewContactVC()
        destVC.contactNameString = passedOverContactName
        contact?.inEditingMode   = true
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    deinit {
        print("DEBUG: ContactsInfo WAS DEINIT")
    }
}


extension ContactInfoVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        editButtonPressed()
        return true
    }
}
