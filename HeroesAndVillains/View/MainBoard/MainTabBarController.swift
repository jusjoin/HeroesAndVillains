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
        
        let downloadsVC = ViewController()
        downloadsVC.title = "Downloads"
        downloadsVC.view.backgroundColor = UIColor.blue
        let historyVC = ViewController()
        historyVC.title = "History"
        historyVC.view.backgroundColor = UIColor.cyan
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image:  UIImage(named: "home"), tag: 0)
        downloadsVC.tabBarItem = UITabBarItem(title: "Search", image:  UIImage(named: "search"), tag: 1)
        historyVC.tabBarItem = UITabBarItem(title: "Favorites", image:  UIImage(named: "favorites"), tag: 2)
        
        let controllers = [homeViewController, downloadsVC, historyVC]
//        tabBarController.viewControllers = controllers
        
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
    }

}
