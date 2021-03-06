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
    var showCharacterFaves = true
    //var showComicFaves = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.tableFooterView = .init(frame: .zero)
        viewModel.updateUI = {
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
        setupNavigation()
        setupFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    func setupFavorites(){
        favoritesTableView.register(UINib(nibName: "CharacterTableCell", bundle: Bundle.main),
                                    forCellReuseIdentifier: "CharacterTableCell")
        favoritesTableView.register(UINib(nibName: "ComicTableCell", bundle: Bundle.main),
                                    forCellReuseIdentifier: "ComicTableCell")
        //viewModel.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.rowHeight = UITableView.automaticDimension
        favoritesTableView.estimatedRowHeight = 100.0
    }
    
    func setupNavigation(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.Keys.favoritesTitle.rawValue
        
        let comicBarButton = UIBarButtonItem(title: Constants.Keys.comicsTitle.rawValue, style: .plain, target: self, action: #selector(comicButtonTapped))
        let characterBarButton = UIBarButtonItem(title: Constants.Keys.charactersTitle.rawValue, style: .plain, target: self, action: #selector(characterButtonTapped))
        self.navigationItem.rightBarButtonItem = comicBarButton
        self.navigationItem.leftBarButtonItem = characterBarButton
        //self.navigationItem.rightBarButtonItems = [UIBarButtonItem](arrayLiteral: rBar1, rBar2)
    }
    
    func update(){
        
        viewModel.GetFavoriteCharacters()
        viewModel.GetFavoriteComics()
    }
    
    @objc func comicButtonTapped(){
        
        //showComicFaves = true
        showCharacterFaves = false
        favoritesTableView.reloadData()
        
    }
    @objc func characterButtonTapped(){
    
        showCharacterFaves = true
        //showComicFaves = false
        favoritesTableView.reloadData()
        
    }

}


extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showCharacterFaves{
            return viewModel.faveCharacters.count
        }else{
            return viewModel.faveComics.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if showCharacterFaves{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableCell", for: indexPath) as! CharacterTableCell
            
            cell.configure(with: aCharacter(with: viewModel.faveCharacters[indexPath.row]))
            //cell.fvcDelegate = self
        
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComicTableCell", for: indexPath) as! ComicTableCell
            
            cell.configure(with: Comic(with: viewModel.faveComics[indexPath.row]))
            //cell.fvcDelegate = self
            
            return cell
        }
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
        
        if showCharacterFaves{
            let detailsVC = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
            detailsVC.viewModel = viewModel
            detailsVC.viewModel.character = aCharacter(with: viewModel.faveCharacters[indexPath.row])
            
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }else{
            let detailsVC = storyboard?.instantiateViewController(withIdentifier: "ComicDetailsViewController") as! ComicDetailsViewController
            detailsVC.viewModel = viewModel
            detailsVC.viewModel.comic = Comic(with: viewModel.faveComics[indexPath.row])
            
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    // MARK: - Stop using this.
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
     */
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deletAction = UITableViewRowAction(style: .default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let swipeMenu = UIAlertController(title: nil,
                                              message: "Confirm delete",
                                              preferredStyle: .actionSheet)
            
            let confirmAction = UIAlertAction(title: "Yes",
                                              style: .default,
                                              handler:
                { _ in
                    let cell = tableView.cellForRow(at: indexPath)!
                    cell.disintegrate { [unowned self] in
                        if self.showCharacterFaves{
                            let char = self.viewModel.faveCharacters[indexPath.row]
                            self.viewModel.deleteCharacterFromFaves(with: char)
                        }else{
                            let com = self.viewModel.faveComics[indexPath.row]
                            self.viewModel.deleteComicFromFaves(with: com)
                        }
                        cell.contentView.alpha = 1.0 // undo side-effect caused by disintegrate
                    }
            })
            let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            swipeMenu.addAction(confirmAction)
            swipeMenu.addAction(cancelAction)
            
            self.present(swipeMenu, animated: true, completion: nil)
        })
        
        return [deletAction]
    }
    
}
