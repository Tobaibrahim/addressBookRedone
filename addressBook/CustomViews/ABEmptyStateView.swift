//
//  ABEmptyStateView.swift
//  addressBook
//
//  Created by TXB4 on 12/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

class ABEmptyStateView: UIView {
    let messageLabel    = ABTitleLabel(textAlignment: .center, fontsSize: 16)
    let logoImageView   = UIImageView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(message:String) {
        super.init(frame:.zero)
        messageLabel.text = message
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor     = .secondaryLabel
    
        guard let safeImageString  = UIImage(named: "emptystate4") else {
            print("Check empty state Image")
            messageLabel.text = nil
            return
        }
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image        = safeImageString
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
                    
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            logoImageView.bottomAnchor.constraint(equalTo:messageLabel.topAnchor,constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}
