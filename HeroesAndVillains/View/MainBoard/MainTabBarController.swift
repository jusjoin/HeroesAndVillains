//
//  MainTabBarController.swift
//  HeroesAndVillains
//
//  Created by Zane on 7/14/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let homeViewController = HomeViewController()
        homeViewController.title = "Home"
        
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        let favoritesVC = FavoritesViewController()
        favoritesVC.title = "Favorites"
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image:  UIImage(named: "home"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image:  UIImage(named: "search"), tag: 1)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image:  UIImage(named: "favorites"), tag: 2)
        
        let controllers = [homeViewController, searchVC, favoritesVC]
//        tabBarController.viewControllers = controllers
        
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
    }

}
