//
//  UserkeysViewModel.swift
//  addressBook
//
//  Created by TXB4 on 22/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import Foundation


struct UserkeysViewModel {
    
    let keys:[String]
    var issearching = false

    
    init(UserKey:UserKeys) {
        self.keys = UserKey.keys
    }

}
