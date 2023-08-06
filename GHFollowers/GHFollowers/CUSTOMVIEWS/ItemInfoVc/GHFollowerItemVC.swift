//
//  GHFollowerItemVC.swift
//  GHFollowers
//
//  Created by jahanzaib on 04/08/2023.
//

import UIKit

class GHFollowerItemVC: GH_ItemInfoVC {

   
    
    override func viewDidLoad() {
            super.viewDidLoad()
            configureItems()
        }
        
        
        private func configureItems() {
            itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
            itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
            actionButton.set(backgroungColor: .systemGreen, title: "Get Followers")
        }
    
    override func actionButtonTapped() {
        delegate.didTabGetFollowers(for: user)
    }

}
