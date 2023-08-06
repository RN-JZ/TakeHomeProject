//
//  FollowersCell.swift
//  GHFollowers
//
//  Created by jahanzaib on 15/07/2023.
//

import UIKit

class FollowersCell: UICollectionViewCell
{
    static let reuseId = "cell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GH_TitleLabel(textAlignment: .center, fontSize: 16)
    let padding:CGFloat = 8
    
    var follower:Follower!
    {
        didSet
        {
            configure()
        }
    }
    override init(frame: CGRect)
    { super.init(frame: frame)
       
     style()
     layout()
     
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension FollowersCell
{
   
    func style()
    {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
    }
    func layout()
    {
        NSLayoutConstraint.activate([
            
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: padding),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            trailingAnchor.constraint(equalTo:  avatarImageView.trailingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: padding),
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            trailingAnchor.constraint(equalTo:  usernameLabel.trailingAnchor, constant: padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
        
    }
}

extension FollowersCell
{
    
    func configure()
    {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
}
