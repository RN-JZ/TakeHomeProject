//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by jahanzaib on 15/07/2023.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholder = UIImage(named: "avatar-placeholder")!
    let cache       = NetworkManager.shared.cache

    override init(frame: CGRect)
    {
     super.init(frame: frame)
     configure()
     
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure()
    {
        layer.cornerRadius  =  10
        clipsToBounds       =  true
        image               =  placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
        func downloadImage(from urlString:String)
        {
    
            let key = NSString(string:urlString)
            if let image =  cache.object(forKey: key)
            {
              
                self.image = image
                return
            }
            guard let image = URL(string: urlString) else{return}
            let task = URLSession.shared.dataTask(with: image)
            {   [weak self]
                data, response, error in
    
                guard let self = self else {
                    print("FAIL TO LOAD IMAGE")
                    return}
                if error != nil { print("FAIL TO LOAD IMAGE")
                    return
    
                }
                guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {return}
                guard let data = data else {print("FAIL TO LOAD IMAGE")
                    return
    
                }
    
                guard  let image = UIImage(data: data) else {return}
                self.cache.setObject(image, forKey: (key))
    
                DispatchQueue.main.async {
                    self.image = image
                }
    
            }.resume()
        }


}
