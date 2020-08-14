//
//  ABDisplayView.swift
//  addressBook
//
//  Created by TXB4 on 14/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//


import UIKit

class ABDisplayView: UIView {
 
 let titleLabel       = ABTitleLabel(textAlignment:.left , fontsSize: 16)
 let underLine:UIView = {
    let line = UIView()
     line.backgroundColor = .systemGray2
     line.alpha = 1
     return line
 }()
 

  override init (frame:CGRect) {
      super.init(frame:frame)
  }
 
 init(displayView:ABBodyLabel,title:String) {
     super.init(frame:.zero)
     
     addSubview(displayView)
     addSubview(titleLabel)
     addSubview(underLine)
     backgroundColor           = .systemGray5
     
     titleLabel.text = title
     titleLabel.anchor(leading: self.leadingAnchor, paddingTop: 10, paddingLeft: 10,height: 20)
     underLine.centerX(inView: self, topAnchor: displayView.bottomAnchor, paddingTop: 2)
     displayView.anchor(top: titleLabel.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 6, paddingLeft: 10, height: 40)
     underLine.setDimensions(width: 360, height: 1)
//    displayView.backgroundColor = .systemPink
 }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
 
 

 }



