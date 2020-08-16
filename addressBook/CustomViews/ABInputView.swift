//
//  ABInputView.swift
//  addressBook
//
//  Created by TXB4 on 13/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

class ABInputView: UIView {
    
    let editImageView   = ABImageView(frame:.zero)
    let titleLabel      = ABTitleLabel(textAlignment:.left , fontsSize: 16)
    
    
    let underLine:UIView = {
       let line = UIView()
        line.backgroundColor = .systemGray2
        line.alpha = 1
        return line
    }()
    
   
     override init (frame:CGRect) {
         super.init(frame:frame)
     }
    
    init(textView:ABTextField,title:String) {
        super.init(frame:.zero)
        
        addSubview(textView)
        addSubview(editImageView)
        addSubview(titleLabel)
        addSubview(underLine)
        backgroundColor           = .systemGray5
        
        titleLabel.text = title
        editImageView.image       = UIImage(named: "pencilWhite")
        editImageView.image       = editImageView.image!.withRenderingMode(.alwaysTemplate)
        editImageView.tintColor   = UIColor.systemGray
        
        titleLabel.anchor(leading: self.leadingAnchor, paddingLeft: 10,height: 20)
        editImageView.anchor(top:self.topAnchor ,trailing: self.trailingAnchor, paddingRight: 20, width: 22, height: 22)
        underLine.centerX(inView: self, topAnchor: textView.bottomAnchor, paddingTop: 5)
        textView.anchor(top: titleLabel.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 6, paddingLeft: 10, height: 40)
        underLine.setDimensions(width: 360, height: 1)

    }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    
   
    }


