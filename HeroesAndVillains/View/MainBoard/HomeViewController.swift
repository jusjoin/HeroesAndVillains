//
//  ViewController.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/3/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var characterCollectionView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
    let viewModel = ViewModel()
    let identifier = Constants.Keys.homeVCIdentifier.rawValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.Keys.homeTitle.rawValue
        let battleBarButton = UIBarButtonItem(title: Constants.Keys.homeGameTitle.rawValue, style: .plain, target: self, action: #selector(battleButtonTapped))
        self.navigationItem.leftBarButtonItem = battleBarButton
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        setupCharacterCollection()
        //searchTableView.tableFooterView = UIView(frame: .zero)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterCollection), name: Notification.Name.TopCharacterNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterCollection), name: Notification.Name.DummyCharactersNotification, object: nil)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib.init(nibName: "ComicCollectionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ComicCollectionTableViewCell")
        mainTableView.register(UINib.init(nibName: "VideoCollectionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "VideoCollectionTableViewCell")
        mainTableView.tableFooterView = .init(frame: .zero)
        //setupComicCollectionTableViewCellDelegate()
           
    }
    
    @objc func battleButtonTapped(){
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Game", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameTabBarController")
//        self.present(newViewController, animated: true, completion: nil)
        
        let gameStoryBoard = UIStoryboard(name: "Game", bundle: nil)
        let gameVC = (gameStoryBoard.instantiateViewController(withIdentifier: "BattleMainViewController"))
//        gameVC.viewModel = viewModel
//        gameVC.viewModel.character = aCharacter(with: viewModel.faveCharacters[indexPath.row])
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        updateCharacterCollection()
    }
    
    func setupCharacterCollection(){
    
        viewModel.getTopCharacters()
    }
    
    
    @objc func updateCharacterCollection(){
        DispatchQueue.main.async{
            self.characterCollectionView.reloadData()
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 175, height: 194)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
        viewModel.character = aCharacter(with: viewModel.topCharacters[indexPath.row])
        detailsVC.viewModel = viewModel
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.characterCollectionView && viewModel.topCharacters.count > 0{
            return viewModel.topCharacters.count
        }else if collectionView == self.characterCollectionView && ViewModel.dummyCharacters.count > 0{
            return ViewModel.dummyCharacters.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.characterCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionCell.identifier, for: indexPath) as! CharacterCollectionCell
            
            //TODO: Add setting to enable/disable adding dummy character
            if viewModel.topCharacters.count > 0{
                let thisCharacter = viewModel.topCharacters[indexPath.row]
                cell.configure(with: aCharacter(with: thisCharacter))
            }else{
                let thisCharacter = ViewModel.dummyCharacters[indexPath.row]
                cell.configure(with: thisCharacter)
            }
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionCell.identifier, for: indexPath) as! CharacterCollectionCell
            
            return cell
        }
    }
    
    
    
}

extension HomeViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            if tableView.bounds.height * 0.4 > 180{
                return tableView.bounds.height * 0.4
            }else {return 180}
        }
        else if indexPath.section == 1{
            if tableView.bounds.height * 0.6 > 200{
                return tableView.bounds.height * 0.6
            }else {return 200}
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {return "Latest Comics"}
        if section == 1 {return "Latest Videos"}
        
        return "Section"
    }
}

extension HomeViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicCollectionTableViewCell", for: indexPath) as! ComicCollectionTableViewCell
        cell.viewModel = viewModel
        cell.vcIdentifier = identifier
        cell.delegate = self
        
        return cell
        }
        
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCollectionTableViewCell", for: indexPath) as! VideoCollectionTableViewCell
            cell.viewModel = viewModel
            cell.vcIdentifier = identifier
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell(frame: CGRect(origin: .zero, size: .zero))
    }
    
    
}

extension HomeViewController: ComicCollectionTableViewCellDelegate{
    func pushToNavigationController(for comic: Comic) {
        
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "ComicDetailsViewController") as! ComicDetailsViewController
        viewModel.comic = comic
        detailsVC.viewModel = viewModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}

extension HomeViewController: VideoCollectionTableViewCellDelegate{
    func presentPlayer(for player: AVPlayer) {
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
        
    }
}

