//
//  ABTextField.swift
//  addressBook
//
//  Created by TXB4 on 12/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

class ABTextField: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: CGRect.zero, textContainer: nil)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
//        layer.cornerRadius          = 10
//        layer.borderWidth           = 2
//        layer.borderColor           = UIColor.systemGray4.cgColor
        
        textColor                   = .secondaryLabel
//        tintColor                   = .label
        textAlignment               = .left
        font                        = UIFont.preferredFont(forTextStyle: .body)
//        adjustsFontSizeToFitWidth   = true
//        minimumFontSize             = 12
        returnKeyType               = .done
        backgroundColor             = .systemGray5
        autocorrectionType          = .no
        
//        placeholder                 = "Type"
        
       
    }
}
