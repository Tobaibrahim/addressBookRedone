//
//  AddNewContactVC.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import Firebase

class AddNewContactVC: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - Properties
    
    var contactNameString: String?
    var inEditingMode    : Bool!
    var imageTapped      = false
    var contactNamePath  = String()
    var contactImageUrl  = String()
    
    
    var Contact: UserData? {
        didSet {
            print("DEBUG: Did set user in addNewContacts")
            configureEditMode()
        }
    }
    
    let imagePicker:UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        return picker
    }()
    
    // Test
    let firstNameTextField:ABTextField = {
        let firstName = ABTextField()
        return firstName
    }()
    
    let nickNameTextField:ABTextField = {
        let firstName = ABTextField()
        return firstName
    }()
    
    let lastNameTextField:ABTextField = {
        let lastName = ABTextField()
        return lastName
    }()
    
    let emailTextField:ABTextField = {
        let firstName = ABTextField()
        return firstName
    }()
    
    let PhoneNumberTextField:ABTextField = {
        let firstName = ABTextField()
        return firstName
    }()
    let AddressTextField:ABTextField = {
        let firstName = ABTextField()
        
        return firstName
    }()
    
    
    let titleLabel: ABTitleLabel = {
        let title       = ABTitleLabel(textAlignment: .left, fontsSize: 14)
        title.text      = "Edit"
        title.textColor = .systemBlue
        title.isUserInteractionEnabled = true
        return title
    }()
    
    
    let contactImage:ABImageView = {
        let image       = ABImageView(frame: .zero)
        image.image     = SFSymbols.icon
        image.layer.cornerRadius = 17
        image.tintColor = .systemGray
        image.isUserInteractionEnabled = true
        
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
    
    let contentView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Helpers
    
    func fetchUsers(user:String) {
        UserService.shared.fetchUser(user: user) { (userData) in
            self.Contact = userData
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
        contentView.heightAnchor.constraint(equalToConstant: 1100).isActive = true

    }
    
    func dismissKeyboard(){
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func configureUI() {
        configureScrollView()
        fetchUsers(user:contactNameString ?? "value")
        dismissKeyboard()
        view.backgroundColor   = .systemGray5
        imagePicker.delegate = self
        
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
            contentView.addSubview(views)
        }
        
        contactImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(profileImageTapped)))
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(profileImageTapped)))
        
        let saveButton                     = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        saveButton.tintColor               = .systemBlue
                
        let backArrowButton                = UIBarButtonItem(image: SFSymbols.backArrow, style: .done, target: self, action:#selector(backButtonPressed))
        backArrowButton.tintColor          = .systemBlue
        
        navigationItem.rightBarButtonItem  = saveButton
        navigationItem.leftBarButtonItem   = backArrowButton
        
        
        contactImage.centerX(inView: contentView, topAnchor: contentView.topAnchor, paddingTop: 70)
        contactImage.setDimensions(width: 96, height: 96)
        titleLabel.centerX(inView: contentView, topAnchor: contactImage.bottomAnchor, paddingTop: 10)
        separatorLine.centerX(inView: contentView, topAnchor: titleLabel.bottomAnchor, paddingTop: 5)
        
        firstNameInputView.anchor(top: separatorLine.bottomAnchor, leading: contentView.leadingAnchor,trailing: contentView.trailingAnchor, paddingTop: 50, paddingLeft: 10, paddingRight: 10, height: 45)
        lastNameInputView.anchor(top: firstNameInputView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 30, paddingLeft: 10,  paddingRight: 10, height: 45)
         nickNameInputView.anchor(top: lastNameInputView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 30, paddingLeft: 10,  paddingRight: 10, height: 45)
        emailInputView.anchor(top: nickNameInputView.bottomAnchor, leading: contentView.leadingAnchor,trailing: contentView.trailingAnchor, paddingTop: 30, paddingLeft: 10, paddingRight: 10, height: 45)
        PhoneNumberInputView.anchor(top: emailInputView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 30, paddingLeft: 10, paddingRight: 10, height: 45)
        AddressInputView.anchor(top: PhoneNumberInputView.bottomAnchor, leading: contentView.leadingAnchor,trailing: contentView.trailingAnchor, paddingTop: 30, paddingLeft: 10, paddingRight: 10, height: 45)
    
    }
    
    func configureEditMode() {
        if inEditingMode == true {
            firstNameTextField.text   = Contact?.firstName
            lastNameTextField.text    = Contact?.lastName
            PhoneNumberTextField.text = Contact?.PhoneNumber
            emailTextField.text       = Contact?.email
            AddressTextField.text     = Contact?.Address
            nickNameTextField.text    = Contact?.nickName
        }
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func profileImageTapped() {
        present(imagePicker, animated: true, completion: nil)
        imageTapped = true
    }
    
    @objc func saveButtonPressed() {
        
        let name = Notification.Name(rawValue: notificationKeys.reloadTableView)
        NotificationCenter.default.post(name: name, object: nil)
    
        guard let firstName    = firstNameTextField.text else {return}
        guard let lastName     = lastNameTextField.text else {return}
        guard let email        = emailTextField.text else {return}
        guard let phone        = PhoneNumberTextField.text else {return}
        guard let nickName     = nickNameTextField.text else {return}
        guard let adddress     = AddressTextField.text else {return}
        
        if (firstNameTextField.text.isEmpty || lastNameTextField.text.isEmpty) {
            presentABAlertOnMainThread(title: "Missing Information", message: "Please fill in the first name and last name fields .😅", buttonTitle: "Okay")
        }
            
        else {
            
            if inEditingMode {
                AuthService.shared.editContact(currentUser: contactNameString ?? "value", firstName: firstName, lastName: lastName, email: email, phone: phone, nickName: nickName, address: adddress)
                if imageTapped == true {
                    AuthService.shared.uploadContactImage(contactImageUrl: contactImageUrl, namePath: contactNameString!)
                }
            }
                
            else {
                AuthService.shared.addContact(firstName: firstName, lastName: lastName, email: email, phone: phone, nickName: nickName, address: adddress, contactImageUrl: "placeholder")
                contactNamePath = firstName  + lastName
                AuthService.shared.uploadContactImage(contactImageUrl: contactImageUrl, namePath: contactNamePath)
            }
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    deinit {
        print("DEBUG: Addnewcontact WAS DEINIT")
    }
    
}


extension AddNewContactVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        self.contactImage.image = profileImage
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.1) else {return}
        let filename = NSUUID().uuidString
        let storage = Storage.storage().reference()
        let storageRef = storage.child("Contact_Image").child(filename)
        
        storageRef.putData(imageData, metadata: nil) { [weak self](meta, error) in
            guard let self =  self else {return}
            storageRef.downloadURL { (url, error) in
                guard let profileImageURL = url?.absoluteString else {return}
                self.contactImageUrl = profileImageURL
                // add contact Image url here
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddNewContactVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveButtonPressed()
        return true
    }
    
}
