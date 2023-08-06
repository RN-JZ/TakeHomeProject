//
//  SceneDelegate.swift
//  GHFollowers
//
//  Created by jahanzaib on 13/07/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        // MARK: - UITABBAR
        let tabbar = UITabBarController()
        
        let vc1 = SearchVC()
        let vc2 = FavoritiesVC()
        
        let nc1 =    templateNavigationController(image:UITabBarItem.SystemItem.search,tag: 0, rootViewController: vc1 , title:"Search")
        let nc2 =    templateNavigationController(image:UITabBarItem.SystemItem.favorites,tag: 1, rootViewController: vc2 , title:"Favorites")

        tabbar.viewControllers = [nc1 , nc2]
        
        tabbar.tabBar.backgroundColor = .systemBackground
        tabbar.tabBar.tintColor = .green
        
        
        
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        
    }
    
    
    func templateNavigationController(image:UITabBarItem.SystemItem, tag:Int , rootViewController:UIViewController , title:String)->UINavigationController
    {
        let nc = UINavigationController(rootViewController: rootViewController)
        nc.tabBarItem = UITabBarItem(tabBarSystemItem:image, tag: tag)
        nc.title = title
        configureNavigationBar()
        return nc


    }
    func configureNavigationBar()
    {
        UINavigationBar.appearance().tintColor = .systemGreen
    }

   


}

