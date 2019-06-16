//
//  FavoritesViewController.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/16/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    let viewModel = ViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.register(UINib(nibName: "CharacterTableCell", bundle: Bundle.main), forCellReuseIdentifier: "CharacterTableCell")
        //viewModel.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        viewModel.GetFavoriteCharacters()
        
    }
    

}


extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.faveCharacters.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableCell", for: indexPath) as! CharacterTableCell
        
        
        cell.configure(with: aCharacter(with: viewModel.faveCharacters[indexPath.row]))
        //cell.fvcDelegate = self
        
        return cell
    }
}

//extension FavoritesViewController: ViewModelDelegate{
//    func UpdateView() {
//        
//        BookTableView.reloadData()
//    }
//    
//    
//}

extension FavoritesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //let book = viewModel.books[indexPath.row]
        
        //let detailVC = storyboard?.instantiateViewController(withIdentifier: "BookDetailsViewController") as! BookDetailsViewController
        
        //detailVC.viewModel.book = viewModel.MakeBook(with: viewModel.faves[indexPath.row])
        
        //self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
