//
//  FavoritesViewController.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/16/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit
import Disintegrate

class FavoritesViewController: UIViewController {
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    let viewModel = ViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.tableFooterView = .init(frame: .zero)
        setupNavigation()
        setupFavorites()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        update()
    }
    
    func setupFavorites(){
        
        viewModel.GetFavoriteCharacters()
        favoritesTableView.register(UINib(nibName: "CharacterTableCell", bundle: Bundle.main), forCellReuseIdentifier: "CharacterTableCell")
        //viewModel.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
    
    func setupNavigation(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.Keys.favoritesTitle.rawValue
    }
    
    func update(){
        viewModel.GetFavoriteCharacters()
        
        favoritesTableView.setNeedsDisplay()
        favoritesTableView.setNeedsLayout()
        favoritesTableView.reloadData()
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
        
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
        detailsVC.viewModel = viewModel
        detailsVC.viewModel.character = aCharacter(with: viewModel.faveCharacters[indexPath.row])
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let deletAction = UITableViewRowAction(style: .default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let swipeMenu = UIAlertController(title: nil, message: "Confirm delete", preferredStyle: .actionSheet)
            
            let confirmAction = UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in
                
                tableView.cellForRow(at: indexPath)!.disintegrate( completion: {() in
                    //let thisIndexPath = [IndexPath(row: indexPath.row, section: 0)]
                    //tableView.deleteRows(at: thisIndexPath, with: .none)
//                    tableView.cellForRow(at: indexPath)?.contentView.subviews.forEach({$0.layer.removeAllAnimations()})
//                    tableView.cellForRow(at: indexPath)?.contentView.layer.removeAllAnimations()
//                    tableView.cellForRow(at: indexPath)?.contentView.layoutIfNeeded()
                    self.viewModel.deleteCharacterFromFaves(with: aCharacter(with: self.viewModel.faveCharacters[indexPath.row]))
//                    var thisCell = tableView.cellForRow(at: indexPath)! as! CharacterTableCell
//                    print(thisCell.characterNameLabel.text)
                    
                    self.update()// tableView.reloadData()
                })
                
            })
            let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            swipeMenu.addAction(confirmAction)
            swipeMenu.addAction(cancelAction)
            
            self.present(swipeMenu, animated: true, completion: nil)
        })
        
        return [deletAction]
    }
    
}
