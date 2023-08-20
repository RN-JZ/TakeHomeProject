//
//  GH-ViewController.swift
//  GHFollowers
//
//  Created by jahanzaib on 19/08/2023.
//

import UIKit

class GH_TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = .systemGreen
        AddSubview()
       
    }
    func AddSubview()
    {
        let vc1 = SearchVC()
        let vc2 = FavoritiesVC()
        
        let nc1 =    templateNavigationController(image:UITabBarItem.SystemItem.search,tag: 0, rootViewController: vc1 , title:"Search")
        let nc2 =    templateNavigationController(image:UITabBarItem.SystemItem.favorites,tag: 1, rootViewController: vc2 , title:"Favorites")

        viewControllers = [nc1 , nc2]
    }
    
    func templateNavigationController(image:UITabBarItem.SystemItem, tag:Int , rootViewController:UIViewController , title:String)->UINavigationController
    {
        let nc = UINavigationController(rootViewController: rootViewController)
        nc.tabBarItem = UITabBarItem(tabBarSystemItem:image, tag: tag)
        nc.title = title
        return nc


    }



}
