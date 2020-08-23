//
//  ContactsCell.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    static let reuseID  = "ContactsCell"
    let editImageView   = ABImageView(frame:.zero)
    let titleLabel      = ABTitleLabel(textAlignment:.left , fontsSize: 16)
    let nickNameLabel   = ABBodyLabel(textAlignment: .left, fontsSize: 13)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(contact:UserDataViewModel){
        nickNameLabel.text = contact.nickName
        
    }
    
    
    private func configure () {
        
        addSubview(editImageView)
        addSubview(titleLabel)
        addSubview(nickNameLabel)
        accessoryType = .disclosureIndicator
        
        backgroundColor           = .systemGray5
        editImageView.image       = SFSymbols.icon
        editImageView.image       = editImageView.image!.withRenderingMode(.alwaysTemplate)
        editImageView.tintColor   = UIColor.systemGray
        editImageView.layer.cornerRadius = 10
        
        titleLabel.anchor(top:self.topAnchor,leading: editImageView.leadingAnchor,paddingTop: 20, paddingLeft: 60,height: 40)
        nickNameLabel.anchor(top: titleLabel.bottomAnchor,leading:editImageView.leadingAnchor, paddingTop: 0,paddingLeft: 60,height: 20)
        editImageView.anchor(top:self.topAnchor ,leading: self.leadingAnchor, paddingTop: 20, paddingLeft: 20, width: 40, height: 40)
    }
    
    
}
