//
//  UserDataViewModel.swift
//  addressBook
//
//  Created by TXB4 on 22/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import Foundation


struct UserDataViewModel {
    
    let firstName:String
    let lastName: String
    let email: String
    let nickName:String
    let PhoneNumber:String
    let Address:String
    let imageURL:String
    var inEditingMode  : Bool
    var imageTapped    : Bool

    
    init(userData:UserData) {
        
        self.firstName = userData.firstName
        self.lastName = userData.lastName
        self.email = userData.email
        self.nickName = userData.nickName
        self.PhoneNumber = userData.PhoneNumber
        self.Address = userData.Address
        self.imageURL = userData.imageURL
        self.inEditingMode = true
        self.imageTapped   = false
    }
}
