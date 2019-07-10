//
//  BattleViewController.swift
//  HeroesAndVillains
//
//  Created by Zane on 7/8/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit
import SpriteKit

class BattleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.Keys.gameBattleTitle.rawValue
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        let value = UIInterfaceOrientation.landscapeRight.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
//    }
    

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//            let value = UIInterfaceOrientation.portrait.rawValue
//            UIDevice.current.setValue(value, forKey: "orientation")
//    }
    
    @objc func canRotate() -> Void {}


}
