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
    lazy var characterCollectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let characterCollectionView =
            UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.40), collectionViewLayout: layout)
        characterCollectionView.backgroundColor = .white
        characterCollectionView.dataSource = self
        characterCollectionView.delegate = self
        characterCollectionView.register(CharacterCollectionCell.self, forCellWithReuseIdentifier: CharacterCollectionCell.identifier)
        
        characterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return characterCollectionView
    }()
    
    lazy var comicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //layout.itemSize = CGSize(width: frame.width, height: frame.height)
        let collectionView =
            UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.30), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ComicCollectionViewCell.self, forCellWithReuseIdentifier: ComicCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var videoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    
//    lazy var mainTableView: UITableView = {
//
//        let tableView = UITableView()
//        tableView.backgroundColor = .white
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(ComicCollectionTableViewCell.self, forCellReuseIdentifier: "ComicCollectionTableViewCell")
//        tableView.register(VideoCollectionTableViewCell.self, forCellReuseIdentifier: "VideoCollectionTableViewCell")
//        tableView.tableFooterView = .init(frame: .zero)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        return tableView
//    }()
    
    let viewModel = HomeViewModel()
    let identifier = Constants.Keys.homeVCIdentifier.rawValue
    
    var comicPeriodDateDescriptor = "thisMonth"
    var comicPeriodDate1 = String()
    var comicPeriodDate2 = String()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: Bundle.main)
        commonInit()
    }
    
    func commonInit() {
        
        view.backgroundColor = .white
        viewModel.GetFavoriteCharacters()
        setupNavigation()
        setupCharacterCollectionView()
        setupComicCollectionView()
        setupVideoCollectionView()
        //setupMainTableView()
        setupObservers()
        setupDates()
        viewModel.getTopCharacters()
        viewModel.getComicsLatest(dateDescriptor: comicPeriodDateDescriptor, forDate1: comicPeriodDate1, forDate2: comicPeriodDate2)
        viewModel.getFeaturedVideos()
    }
    
    func setupNavigation(){
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.Keys.homeTitle.rawValue
        let battleBarButton = UIBarButtonItem(title: Constants.Keys.homeGameTitle.rawValue, style: .plain, target: self, action: #selector(battleButtonTapped))
        self.navigationItem.leftBarButtonItem = battleBarButton
    }
    
    func setupCharacterCollectionView(){
        
        view.addSubview(characterCollectionView)
        
        NSLayoutConstraint.activate([
        characterCollectionView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            characterCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            characterCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
    }
    
    func setupComicCollectionView(){
        
        view.addSubview(comicCollectionView)
        comicCollectionView.dataSource = self
        comicCollectionView.delegate = self
        NSLayoutConstraint.activate([
            comicCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            comicCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            //comicCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor)
            comicCollectionView.topAnchor.constraint(equalTo: characterCollectionView.bottomAnchor),
            comicCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    func setupVideoCollectionView(){
        
        view.addSubview(videoCollectionView)
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
        NSLayoutConstraint.activate([
            videoCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            videoCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30),
            //comicCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor)
            videoCollectionView.topAnchor.constraint(equalTo: comicCollectionView.bottomAnchor),
            videoCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            videoCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NotificationCenter.default.addObserver(self, selector: #selector(updateComicCollection), name: Notification.Name.ComicsNotification, object: nil)
    }
//    func setupMainTableView(){
//
//        view.addSubview(mainTableView)
//
//        NSLayoutConstraint.activate([
//
//            mainTableView.topAnchor.constraint(equalTo: characterCollectionView.bottomAnchor),
//            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            mainTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            mainTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//    }
    
    func setupObservers(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterCollection), name: Notification.Name.TopCharacterNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterCollection), name: Notification.Name.DummyCharactersNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateComicCollection), name: Notification.Name.ComicsNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateVideosCollection), name: Notification.Name.VideosNotification, object: nil)
    }
    
    @objc func battleButtonTapped(){
        
        let gameStoryBoard = UIStoryboard(name: "Game", bundle: nil)
        let gameVC = (gameStoryBoard.instantiateViewController(withIdentifier: "BattleMainViewController"))

        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        updateCharacterCollection()
    }
    
    
    @objc func updateCharacterCollection(){
        DispatchQueue.main.async{
            self.characterCollectionView.reloadData()
        }
    }
    
    @objc func updateComicCollection(){
        DispatchQueue.main.async{
            self.comicCollectionView.reloadData()
        }
    }
    
    @objc func updateVideosCollection(){
        DispatchQueue.main.async{
            self.videoCollectionView.reloadData()
        }
    }
    
    func setupDates(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        comicPeriodDate2 = dateFormatter.string(from: today)
        let thePast = Calendar.current.date(byAdding: .weekOfYear, value: -24, to: Date())!
        comicPeriodDate1 = dateFormatter.string(from: thePast)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView{
        case self.characterCollectionView:
            let width = collectionView.frame.width * 0.4
            let height = collectionView.frame.height * 0.7
            return .init(width: width, height: height)
            
        case self.comicCollectionView:
            let width = collectionView.frame.width * 0.3
            let height = collectionView.frame.height * 0.9
            return .init(width: width, height: height)
            
        case self.videoCollectionView:
            let width = collectionView.frame.width * 0.8
            let height = collectionView.frame.height * 0.9
            return .init(width: width, height: height)
            
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView{
        case self.characterCollectionView:
            let detailsVC = CharacterDetailsViewController(thisCharacter: aCharacter(with: viewModel.topCharacters[indexPath.row]))
            self.navigationController?.pushViewController(detailsVC, animated: true)
            
        case self.comicCollectionView:
            let detailsVC = ComicDetailsViewController(thisComic: Comic(with: viewModel.comics[indexPath.row]))
            self.navigationController?.pushViewController(detailsVC, animated: true)
            
        case self.videoCollectionView:
            let video = viewModel.featuredVideos[indexPath.row].lowURL
            let videoURL = URL(string: video!)!
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            
            present(playerViewController, animated: true) {
                player.play()
            }
            
        default:
            print("")
        }
    }
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case self.characterCollectionView:
            if viewModel.topCharacters.count > 0{
                return viewModel.topCharacters.count
            }else if viewModel.dummyCharacters.count > 0{
                return viewModel.dummyCharacters.count
            }
            
        case self.comicCollectionView:
            return viewModel.comics.count
            
        case self.videoCollectionView:
            return viewModel.featuredVideos.count
            
        default:
            return 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case self.characterCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionCell.identifier, for: indexPath) as! CharacterCollectionCell
            cell.thisCharacter = aCharacter(with: viewModel.topCharacters[indexPath.row])
            cell.viewModelDelegate = self
            //TODO: Add setting to enable/disable adding dummy character
            if viewModel.topCharacters.count > 0{
                let thisCharacter = viewModel.topCharacters[indexPath.row]
                cell.configure(with: aCharacter(with: thisCharacter))
            }else{
                let thisCharacter = viewModel.dummyCharacters[indexPath.row]
                cell.configure(with: thisCharacter)
            }
            
            return cell
            
        case self.comicCollectionView:
            let cell = comicCollectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionViewCell.identifier, for: indexPath as IndexPath) as! ComicCollectionViewCell
            
            let thisComic = viewModel.comics[indexPath.row]
            cell.configure(with: Comic(with: thisComic))
            
            return cell
        
        case self.videoCollectionView:
            let cell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath as IndexPath) as! VideoCollectionViewCell
            
            let thisVideo = viewModel.featuredVideos[indexPath.row]
            cell.configure(with: thisVideo)
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionCell.identifier, for: indexPath) as! CharacterCollectionCell
            
            return cell
            
        }
    }
    
    
    
}

extension HomeViewController: ComicCollectionTableViewCellDelegate{
    func pushToNavigationController(for comic: Comic) {
        
        let detailsVC = ComicDetailsViewController()
//        viewModel.comic = comic
//        detailsVC.viewModel = viewModel
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

extension HomeViewController: ViewModelCharacterFavoritesDelegate{
    func deleteCharacterFromFaves(char: aCharacter) -> Bool {
        return viewModel.deleteCharacterFromFaves(char: char)
    }
    
    func saveCharacterToFaves(char: aCharacter) -> Bool{
        return viewModel.saveCharacterToFaves(char: char)
    }
    
    func deleteCharacterFromFaves(char: aCharacter) {
        viewModel.deleteCharacterFromFaves(char: char)
    }
    
    func isFaved(char: aCharacter) -> Bool {
        return viewModel.isFaved(char)
    }
}

