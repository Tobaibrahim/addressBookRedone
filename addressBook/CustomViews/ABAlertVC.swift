//
//  ABAlertVC.swift
//  addressBook
//
//  Created by TXB4 on 16/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//


import UIKit

class ABAlertVC: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius  = 16
        view.layer.borderWidth   =  2
        view.layer.borderColor   = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor     = .systemBackground
        return view
    }()

    let actionButton = ABButton(backgroundColor: .systemBlue, title: "Okay")
    let titleLabel    = ABTitleLabel(textAlignment:.center, fontsSize: 20)
    let messageLabel  = ABBodyLabel(textAlignment: .center, fontsSize: 15)
    
    
    // re-used our gf button for this VC

    var alertTitle:String?
    var message: String?
    var buttonTitle:String?
    var padding:CGFloat = 20
    
    
    // we have created a initializer so when when we create an instance of this class we can pick the alert title, buttonTitle, and message
    init(alertTitle:String,message:String,buttonTitle:String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle  = alertTitle
        self.message     = message
        self.buttonTitle = buttonTitle
        
        ///?????? test this after
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        // we set the background colour for the vc to black using rgb values and the alpha section allows us to set the transparency.
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
            ])
}

    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
        
        ])
    }
    
    func configureActionButton () {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
        
        }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        NSLayoutConstraint.activate([
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        
        ])
    }
    
    
    @objc func dismissVC () {
        dismiss(animated: true, completion: nil)
    }
}
