//
//  ABImageView.swift
//  addressBook
//
//  Created by TXB4 on 11/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

class ABImageView: UIImageView {
    
    let cache = AuthService.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    
    private func configure() {
        
        guard let avatarPlaceholder = UIImage(named: "john") else {
            print("Check Image Name!")
            
            return
        }

        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = avatarPlaceholder
        translatesAutoresizingMaskIntoConstraints = false
        contentMode        = .scaleAspectFill
        clipsToBounds      = true
        }
        
    
    func downloadImage(from urlString:String) {

        if let image = cache.object(forKey: urlString as NSString) {
            self.image = image

            return
        }

        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in

            guard let self = self else {return}

            if error != nil {return}

            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {return}

            guard let data = data else {return}

            guard let image = UIImage(data: data) else {return}

            self.cache.setObject(image, forKey: urlString as NSString)

            DispatchQueue.main.async {

            self.image = image

            }
            }
        task.resume()
    }
}

