////
////  ContactsAddCell.swift
////  addressBook
////
////  Created by TXB4 on 12/08/2020.
////  Copyright © 2020 TobaIbrahim. All rights reserved.
////
//
//import UIKit
//
//class ContactsAddCell: UITableViewCell {
//    
//       static let reuseID  = "ContactsAddCell"
//       let editImageView   = ABImageView(frame:.zero)
//       let titleLabel      = ABTitleLabel(textAlignment:.left , fontsSize: 16)
//       let textInput       = ABTextField(frame:.zero)
//       
//        
//        
//    
//    
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        configure()
//    }
//    
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//
//    
//    
//    private func configure () {
//        
//        addSubview(editImageView)
//        addSubview(titleLabel)
//        addSubview(textInput)
//        
//        backgroundColor           = .systemGray5
//        editImageView.image       = UIImage(named: "pencilWhite")
//        editImageView.image       = editImageView.image!.withRenderingMode(.alwaysTemplate)
//        editImageView.tintColor   = UIColor.systemGray
//        textInput.anchor(top: titleLabel.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 6, paddingLeft: 10, paddingRight: 50, width: 150, height: 20)
//    
//        titleLabel.anchor(leading: self.leadingAnchor, paddingTop: 10, paddingLeft: 10,height: 20)
//        editImageView.anchor(top:self.topAnchor ,trailing: self.trailingAnchor,paddingTop: 10, paddingRight: 20, width: 22, height: 22)
//    
//}
//
//   
//
//}
