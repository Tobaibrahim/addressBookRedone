//
//  UserService.swift
//  addressBook
//
//  Created by TXB4 on 15/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import Firebase


struct UserService {
    static let shared = UserService()
    let ref           = Database.database().reference()
    
    
    func fetchUser(user:String,completion: @escaping(UserData) -> Void) {
        ref.child("NewContacts").child(user).observeSingleEvent(of: .value) { (snapshot) in
            // pass in the keyvalue to get specific user
            
            guard let dictionary = snapshot.value as? [String:AnyObject] else {return}
            let snapshopValue       = snapshot.value as? NSDictionary
            guard let values        = snapshopValue?.allKeys else {return}
            guard let val           = values as? [String] else {return}
            print("DEBUG: KEYS = \(val.sorted())")
            let contact = UserData(keys: val.sorted(), dictionary: dictionary )
            completion(contact)
            
        }}
    
    
    func fetchKey(completion: @escaping(Contactskeys) -> Void) {
        ref.child("NewContacts").observeSingleEvent(of: .value) { (snapshot) in
        // pass in the keyvalue to get specific user
            let snapshopValue       = snapshot.value as? NSDictionary
            guard let values        = snapshopValue?.allKeys else {return}
            guard let values2       = snapshopValue?.allValues else {return}
            guard let val           = values as? [String] else {return}
            print("DEBUG: VALUES = \(values2)")
            let keys = Contactskeys(keys: val.sorted())
            completion(keys)
        }
        
        
    
}





        
  
}
