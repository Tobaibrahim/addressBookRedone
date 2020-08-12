//
//  ContactsCell.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

class ContactsCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    // this works as the cell identifier
     
    let avatarImageView = ABImageView(frame:.zero)
    let usernameLabel = ABTitleLabel(textAlignment:.left, fontsSize: 18)
    let nickNameLabel = ABBodyLabel(textAlignment: .left, fontsSize: 13)
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
//    func set(follower:Follower){
//        usernameLabel.text = follower.login
//        avatarImageView.downloadImage(from: follower.avatarUrl)
//
//        // this function allows us to pass in the folower class/ login property and call it in our folowers list vc
//
//    }
    
    
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding:CGFloat = 8

        NSLayoutConstraint.activate(
            [avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(lessThanOrEqualTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
            
            ])
    }
    
}
