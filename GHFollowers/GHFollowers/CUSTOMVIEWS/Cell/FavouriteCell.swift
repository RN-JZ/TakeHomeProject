


import Foundation
import UIKit

class FavouriteCell:UITableViewCell
{
    static let reuseId  = "FavouritCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GH_TitleLabel(textAlignment: .center, fontSize: 16)
    let padding:CGFloat = 12
    
    var follower:Follower!
    {
        didSet
        {
            configure()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        Style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension FavouriteCell
{
    func Style()
    {
        accessoryType = .disclosureIndicator
        addSubview(avatarImageView)
        addSubview(usernameLabel)
    }
    func layout()
    {
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor , constant: padding),
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])
        
    }
    
   
    
    func configure()
    {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
}
