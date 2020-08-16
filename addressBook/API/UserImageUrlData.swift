//
//  UserImageUrlData.swift
//  addressBook
//
//  Created by TXB4 on 16/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import Foundation


struct UserImageUrlData {


let imageURL:String


init(keys:[String],dictionary:[String:AnyObject]) {

   
    self.imageURL  = dictionary["ContactImageURL"] as? String ?? ""
}
}
