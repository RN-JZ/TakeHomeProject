//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by jahanzaib on 14/07/2023.
//

import UIKit
import SwiftUI


protocol FollowerListVcDelegate:AnyObject
{
    func disRequestFollowers(for username:String)
}
class FollowersListVC: UIViewController {
    var name:String!
    var collectionView:UICollectionView!
    var followers:[Follower] = []
    var filterfollowers:[Follower] = []
    let searchbar = UISearchController()
    var datasource:UICollectionViewDiffableDataSource<Section,Follower>! = nil
    var pageCount = 1
    var hasMoreFollowers = true
    enum Section
    {
        case main
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
   
       configureController()
       configureCollectionView()
       getFollowers(username: name, page: pageCount)
       configureDataSource()
       
        
       navigationItem.searchController     =    searchbar
       searchbar.searchResultsUpdater      =    self
       searchbar.searchBar.delegate        =    self
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Create a heart button with a custom image
              
               let heartButton = UIButton(type: .custom)
               heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
               heartButton.tintColor = .green
               heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
               let heartBarButtonItem = UIBarButtonItem(customView: heartButton)
               navigationItem.rightBarButtonItem = heartBarButtonItem
           
        
    }
    
    @objc func heartButtonTapped()
    {
        showLoadindView()
        NetworkManager.shared.getUserInfo(for: name) {[weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result
            {
            case .success(let user):
                let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistanceManager.updateWithFavourite(favourite: favourite, action: .add) { [weak self] error in
                    guard let self = self else {return}
                    guard let error = error else
                    {
                        self.presenGHAlertOnMainThread(title: "Sucess", message: "Added data to favourite", buttonTitle: "Ok")
                        return
                    }
                    
                    self.presenGHAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                    
                }
               break
            case.failure(let errorMessage):
                 
              break
            }
            
        }
            
        
    }
    
    func configureController()
    {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
       
    }
    
    func configureCollectionView()
    {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout:UIHelper.createThreeColoumnFlowLayout(in:view))
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseId)
        view.addSubview(collectionView)
        collectionView.delegate = self
        

    }
    
    
   
    
    
    func getFollowers(username:String , page:Int)
    {
        showLoadindView()
        NetworkManager.shared.getFollowers(for: username, page: page) {[weak self] result in
           
            guard let self = self else {return}
            self.dismissLoadingView()
           switch result
           {
           case .success(let followers):
               if followers.count < 100 {self.hasMoreFollowers = false}
               self.followers.append(contentsOf:followers)
               self.updateData(on: followers)
               
               if followers.isEmpty
               {
                   let message = "USER HAVE NO FOLLOWERS"
                   DispatchQueue.main.async {
                       self.showEmptyStateView(with: message, In: self.view)
                   }
                   
               }
              
           case.failure(let errorMessage):
                self.presenGHAlertOnMainThread(title: "SOMETHING WENT WRONG", message:errorMessage.rawValue, buttonTitle: "close")
               
           }
           
            
        }
    }
    
    func configureDataSource()
    {
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in

            let cell =   collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.reuseId , for: indexPath) as! FollowersCell
            cell.follower = follower
            return cell
            
        })
    }
    
    func updateData(on followers:[Follower])
    {
        var snapshot = NSDiffableDataSourceSnapshot<Section , Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers, toSection: .main)
        datasource.apply(snapshot , animatingDifferences: true)
        
        
    }


}

extension FollowersListVC:UICollectionViewDelegate
{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset        = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        
        if offset+height >= contentHeight
        {
            guard hasMoreFollowers else {
                print("NO MORE FOLLOWERS")
                return}
            pageCount += 1
            getFollowers(username: name, page: pageCount)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = !filterfollowers.isEmpty ? filterfollowers[indexPath.item] : followers[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.name = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    
    }
    
 
}

extension FollowersListVC: UISearchResultsUpdating , UISearchBarDelegate
{
    func  updateSearchResults(for searchController : UISearchController)
    {
        
        guard let text = searchController.searchBar.text,!text.isEmpty  else {return}
        filterfollowers =  followers.filter {$0.login.lowercased().contains(text.lowercased())}
        self.updateData(on: filterfollowers)
    }
     
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         filterfollowers = []
         self.updateData(on: followers)
     }
}

// MARK: - Delegate
extension FollowersListVC:FollowerListVcDelegate
{
    func disRequestFollowers(for username: String) {
        
        
        
        self.name = username
        pageCount = 1
        followers.removeAll()
        filterfollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: name, page: pageCount)
        
        
    }
    
    
}
