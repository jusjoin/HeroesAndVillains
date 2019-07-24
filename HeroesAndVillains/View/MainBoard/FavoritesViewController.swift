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
    
    lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(CharacterTableCell.self, forCellReuseIdentifier: CharacterTableCell.identifier)
        tableView.register(ComicTableCell.self, forCellReuseIdentifier: ComicTableCell.identifier)
        tableView.tableFooterView = .init(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel = ViewModel()
    var showCharacterFaves = true
    //var showComicFaves = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupFavoritesTableView()
        
        ViewModel.updateUI = {
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    func setupFavoritesTableView(){
        view.addSubview(favoritesTableView)
        
//        favoritesTableView.rowHeight = UITableView.automaticDimension
//        favoritesTableView.estimatedRowHeight = 100.0
        
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        
    }
    
//    func setupFavorites(){
//        favoritesTableView.register(CharacterTableCell.self,
//                                    forCellReuseIdentifier: "CharacterTableCell")
//        favoritesTableView.register(ComicTableCell.self,
//                                    forCellReuseIdentifier: "ComicTableCell")
//        //viewModel.delegate = self
//        favoritesTableView.dataSource = self
//        favoritesTableView.delegate = self
//
//    }
    
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
            return ViewModel.faveCharacters.count
        }else{
            return viewModel.faveComics.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if showCharacterFaves{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableCell", for: indexPath) as! CharacterTableCell
            
            cell.configure(with: aCharacter(with: ViewModel.faveCharacters[indexPath.row]))
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
            let detailsVC = CharacterDetailsViewController()
            detailsVC.viewModel = viewModel
            detailsVC.viewModel.character = aCharacter(with: ViewModel.faveCharacters[indexPath.row])
            
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }else{
            let detailsVC = ComicDetailsViewController()
            detailsVC.viewModel = viewModel
            detailsVC.viewModel.comic = Comic(with: viewModel.faveComics[indexPath.row])
            
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    // MARK: - Stop using this.
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
 
    
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
                            let char = ViewModel.faveCharacters[indexPath.row]
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
