//
//  UserData.swift
//  addressBook
//
//  Created by TXB4 on 12/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit


struct UserData {

    let firstName:String
    let lastName: String
    let email: String
    let nickName:String
    let PhoneNumber:String
    let Address:String
    let imageURL:String
    let keys:[String]

    init(keys:[String],dictionary:[String:AnyObject]) {

        self.firstName = dictionary["FirstName"] as? String ?? ""
        self.lastName  = dictionary["LastName"] as? String ?? ""
        self.email     = dictionary["Email"] as? String ?? ""
        self.nickName  = dictionary["NickName"] as? String ?? ""
        self.PhoneNumber = dictionary["Phone"] as? String ?? ""
        self.Address   = dictionary["Address"] as? String ?? ""
        self.imageURL  = dictionary["ContactImageURL"] as? String ?? ""
        self.keys      = keys
    }

}
