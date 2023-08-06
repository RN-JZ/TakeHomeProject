//
//  GHUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by jahanzaib on 03/08/2023.
//

import UIKit

class GHUserInfoHeaderVC: UIViewController {
    
    let avaterImage            =  GFAvatarImageView(frame: .zero)
    let usernameLabel          =  GH_TitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel              =  GH_SecondaryLabel(fontSize: 18)
    let locationImageview      =  UIImageView()
    let locationLable          =  GH_SecondaryLabel(fontSize: 18)
    let BioLable               =  GH_BodyLabel(textAlignment: .left)
    
    
    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        Layout()
        ConfigureUIElement()
        
    }
    func ConfigureUIElement()
    {
        avaterImage.downloadImage(from: user.avatarUrl)
        usernameLabel.text          = user.login
        nameLabel.text              = user.name ?? " "
        locationLable.text          = user.location ?? "NO LOC"
        BioLable.text               = user.bio ?? "NO BIO"
        BioLable.numberOfLines      = 4
        locationImageview.image     = UIImage(systemName: SFSymbols.location)
        locationImageview.tintColor = .secondaryLabel
    }
    
    init(user:User)
    {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    

}

extension GHUserInfoHeaderVC
{
    func style()
    {
        view.addSubview(avaterImage)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageview)
        view.addSubview(locationLable)
        view.addSubview(BioLable)
        locationImageview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func Layout()
    {
        let textImagePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            
            avaterImage.topAnchor.constraint(equalTo: view.topAnchor),
            avaterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avaterImage.widthAnchor.constraint(equalToConstant: 90),
            avaterImage.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo:avaterImage.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avaterImage.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
        
            nameLabel.centerYAnchor.constraint(equalTo: avaterImage.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avaterImage.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            locationImageview.bottomAnchor.constraint(equalTo: avaterImage.bottomAnchor),
            locationImageview.leadingAnchor.constraint(equalTo: avaterImage.trailingAnchor, constant: textImagePadding),
            locationImageview.widthAnchor.constraint(equalToConstant: 20),
            locationImageview.heightAnchor.constraint(equalToConstant: 20),
            
            
            locationLable.centerYAnchor.constraint(equalTo: locationImageview.centerYAnchor),
            locationLable.leadingAnchor.constraint(equalTo: locationImageview.trailingAnchor),
            locationLable.trailingAnchor.constraint(equalTo: view.trailingAnchor ),
            locationLable.heightAnchor.constraint(equalToConstant: 20),
            
            
            BioLable.bottomAnchor.constraint(equalTo:avaterImage.bottomAnchor , constant: 60),
            BioLable.leadingAnchor.constraint(equalTo: avaterImage.leadingAnchor),
            BioLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            BioLable.heightAnchor.constraint(equalToConstant: 60)
            
            
            
            
            
            
            
        ])
    }
}
