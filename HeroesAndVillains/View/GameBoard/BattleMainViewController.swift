//
//  BattleMainViewController.swift
//  HeroesAndVillains
//
//  Created by Zane on 7/8/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class BattleMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.Keys.gameMainTitle.rawValue
        let battleBarButton = UIBarButtonItem(title: Constants.Keys.gameBattleTitle.rawValue, style: .plain, target: self, action: #selector(gameButtonTapped))
        self.navigationItem.rightBarButtonItem = battleBarButton
//        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    
    @objc func gameButtonTapped(){

        let gameStoryBoard = UIStoryboard(name: "Game", bundle: Bundle.main)
        let gameVC = (gameStoryBoard.instantiateViewController(withIdentifier: "BattleGameViewController"))
        self.navigationController?.pushViewController(gameVC, animated: true)
    }

}
