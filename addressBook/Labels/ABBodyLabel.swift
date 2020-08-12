//
//  ABBodyLabel.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit


class ABBodyLabel: UILabel {

override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textAlignment:NSTextAlignment,fontsSize:CGFloat) {
    super.init(frame: .zero)
    self.textAlignment = textAlignment
    self.font = UIFont.systemFont(ofSize: fontsSize, weight: .light)
    configure()
    }
    
    
    private func configure () {
        textColor                 = .systemGray
        adjustsFontSizeToFitWidth = true
        font                      = UIFont.preferredFont(forTextStyle: .body)
        minimumScaleFactor        = 0.75
        lineBreakMode             = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines             = 4
    
    }
}


