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

        textColor                   = .secondaryLabel
        textAlignment               = .left
        font                        = UIFont.preferredFont(forTextStyle: .body)
        returnKeyType               = .done
        backgroundColor             = .systemGray5
        autocorrectionType          = .no
       
    }
}
