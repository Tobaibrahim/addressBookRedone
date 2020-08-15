//
//  AuthService.swift
//  addressBook
//
//  Created by TXB4 on 14/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredentials {
    
    let email:String
    let password:String

    
}

struct AuthService {
    
    static let shared  = AuthService()
    static let uid     = Auth.auth().currentUser?.uid
    let ref            = Database.database().reference()
    
    private init () {}
    
    
    
    func uploadContactImage(contactImageUrl:String,namePath:String) {
        let url = ["ContactImageURL":contactImageUrl]
        ref.child("NewContacts").child(namePath).updateChildValues(url)
      
    }
    
    
    func addContact(firstName:String,lastName:String,email:String,phone:String,nickName:String,address:String,contactImageUrl:String) {
        let fullName = firstName + lastName
        let values = ["FirstName":firstName,"LastName":lastName,"Email":email,"Phone":phone,"NickName":nickName,
                      "Address":address,"ContactImageURL":contactImageUrl]
        ref.child("NewContacts").child(fullName).setValue(values)

    }
    
    
    func editContact(firstName:String,lastName:String,email:String,phone:String,nickName:String,address:String) {
           let fullName = firstName + lastName
           let values = ["FirstName":firstName,"LastName":lastName,"Email":email,"Phone":phone,"NickName":nickName,
                         "Address":address]
           ref.child("NewContacts").child(fullName).updateChildValues(values)

       }
    

    
    
}
