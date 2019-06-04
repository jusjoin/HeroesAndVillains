//
//  SearchViewController.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/3/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.Keys.searchTitle.rawValue
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
