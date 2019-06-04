//
//  ViewController.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/3/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.Keys.homeTitle.rawValue
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }


}

