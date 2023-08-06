//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by jahanzaib on 03/08/2023.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate:AnyObject
{
    func didTabGitHubProfile(for user:User)
    func didTabGetFollowers(for user: User)
    
}


class UserInfoVC: UIViewController {
    var name:String!
    let header      = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemView:[UIView] = []
    let padding:CGFloat = 20
    weak var delegate:FollowerListVcDelegate!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureViewController()
        getUserInfo()
        style()
        layout()
    }
    // MARK: - CONFIGURATION
    func configureViewController()
    {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self,action:#selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: - UI Element
    func ConfigureUIElement(user:User)
    {
        let repo = GHRepoItemVC(user: user)
        repo.delegate = self
        
        let follower = GHFollowerItemVC(user: user)
        follower.delegate = self
        
        self.add(childVC: GHUserInfoHeaderVC(user: user), to: self.header)
        self.add(childVC: repo, to: self.itemViewOne)
        self.add(childVC:  follower, to: self.itemViewTwo)
    }
    
    // MARK: - NETWORK CALL
    func getUserInfo()
    {
        NetworkManager.shared.getUserInfo(for: name!) { [weak self] result in
            guard let self = self else {return}
            switch result
            {
            case .success(let user):
                DispatchQueue.main.async {
                    self.ConfigureUIElement(user: user)
                }
            case .failure(let error):
                self.presenGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc func dismissVC()
    {
        dismiss(animated: true)
    }
    // MARK: - ADDING INFO HEADER 
    func add(childVC:UIViewController , to containerView:UIView)
    {
        addChild(childVC)
        
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        
        childVC.didMove(toParent: self)
    }
    


}

extension UserInfoVC
{
    
    func style()
    {
        
        itemView = [header , itemViewOne , itemViewTwo]
        for item in itemView
        {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
            
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            ])
            
        }
       
    }
    
    func layout()
    {
       
        NSLayoutConstraint.activate([
            
           
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: header.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140)
            
            
            
        
    ])
        
        
    }
}

extension UserInfoVC:UserInfoVCDelegate
{
    func didTabGetFollowers(for user: User) {
        guard user.followers != 0
        else {
            self.presenGHAlertOnMainThread(title: "NO followers", message: "USE HAVE NO FOLLOWRS Please Follow", buttonTitle: "OK")
            return
        }
        print("CLCIKED")
        delegate.disRequestFollowers(for: user.login)
        dismissVC()
    }
    
    func didTabGitHubProfile(for user: User) {
        print("GIT HUB PROFILE")
        guard let url = URL(string: user.htmlUrl) else
        {
            self.presenGHAlertOnMainThread(title: "Invalid URL", message: "The url is invalid", buttonTitle: "OK")
            return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true, completion: nil)
        
        
        
        
    }
    
    
    
   
    
}
