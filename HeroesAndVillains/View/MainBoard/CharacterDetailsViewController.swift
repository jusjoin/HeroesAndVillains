//
//  CharacterDetailsViewController.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/10/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    lazy var containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        //label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var characterDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var faveButton: UIButton = {
        let button = UIButton()
        let origImage = UIImage(named: "favorites")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Details", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var wikiButton: UIButton = {
        let button = UIButton()
        button.setTitle("Wiki", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var comicsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Comics", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var addToTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add To Team", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var detailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComicCollectionTableViewCell.self, forCellReuseIdentifier: "ComicCollectionTableViewCell")
        tableView.register(CharacterStatsTableViewCell.self, forCellReuseIdentifier: "CharacterStatsTableViewCell")
        tableView.tableFooterView = .init(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var viewModel : ViewModel!
    let identifier = Constants.Keys.characterDetailsVCIdentifier.rawValue
    
    var faved = false{ // move to viewModel?
        didSet{
            if faved == true{
                let origImage = UIImage(named: "favorites-filled")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                faveButton.setImage(tintedImage, for: .normal)
                faveButton.tintColor = .yellow
            }else{
                let origImage = UIImage(named: "favorites")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                faveButton.setImage(tintedImage, for: .normal)
                faveButton.tintColor = .blue
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        SetupContainerView()
        SetupDescriptionScrollView()
        SetupCharacterImageView()
        SetupFaveButton()
        SetupCharacterNameLabel()
        SetupDetailsButton()
        SetupWikiButton()
        SetupComicsButton()
        SetupAddToTeamButton()
        SetupDetailsTableView()
        SetupComicCollection()
        SetupCharacterStatsCollection()
        SetupCharacterDescriptionLabel()
        
        detailsButton.addTarget(self, action: #selector(detailsButtonTapped(_:)), for: .touchUpInside)
        wikiButton.addTarget(self, action: #selector(wikiButtonTapped(_:)), for: .touchUpInside)
        comicsButton.addTarget(self, action: #selector(comicsButtonTapped(_:)), for: .touchUpInside)
        addToTeamButton.addTarget(self, action: #selector(addToTeamButtonTapped(_:)), for: .touchUpInside)
        
    }
    
    func SetupContainerView(){
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            ])
        
    }
    
    func SetupCharacterImageView(){
        
        containerView.addSubview(characterImageView)
        NSLayoutConstraint.activate([
            
            characterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            characterImageView.bottomAnchor.constraint(equalTo: descScrollView.topAnchor),
            characterImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5),
            characterImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4)
            
            
            ])
        
        dlManager.download(viewModel.character.image){[unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)
                self.characterImageView.image = image
            }
        }
        
        print(viewModel.character.description)
        
        faved = viewModel.isFaved(viewModel.character)
        
    }
    
    func SetupFaveButton(){
        characterImageView.addSubview(faveButton)
        faveButton.addTarget(self, action: #selector(faveButtonTapped(_:)), for: .touchUpInside)
        faveButton.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor, constant: 5).isActive = true
        faveButton.topAnchor.constraint(equalTo: characterImageView.topAnchor, constant: -5).isActive = true
        faveButton.widthAnchor.constraint(equalTo: characterImageView.widthAnchor, multiplier: 0.2).isActive = true
        faveButton.heightAnchor.constraint(equalTo: characterImageView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func SetupCharacterNameLabel(){
        view.addSubview(characterNameLabel)
        characterNameLabel.text = viewModel.character.name
        
        NSLayoutConstraint.activate([
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 5),
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.topAnchor, constant: 5),
            characterNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func SetupDescriptionScrollView(){
        
        containerView.addSubview(descScrollView)
        NSLayoutConstraint.activate([
           //  descScrollView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.15),
            descScrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descScrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            descScrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
            ])
    }
    
    func SetupCharacterDescriptionLabel(){
        
        characterDescriptionLabel.text = viewModel.character.description
        descScrollView.addSubview(characterDescriptionLabel)
        
        NSLayoutConstraint.activate([
            characterDescriptionLabel.topAnchor.constraint(equalTo: descScrollView.topAnchor, constant: 5),
            characterDescriptionLabel.trailingAnchor.constraint(equalTo: descScrollView.trailingAnchor),
            characterDescriptionLabel.leadingAnchor.constraint(equalTo: descScrollView.leadingAnchor),
            characterDescriptionLabel.widthAnchor.constraint(equalTo: descScrollView.widthAnchor),
            characterDescriptionLabel.bottomAnchor.constraint(equalTo: descScrollView.bottomAnchor)
            ])
    }
    
    func SetupDetailsButton(){
        containerView.addSubview(detailsButton)
        
        NSLayoutConstraint.activate([
            detailsButton.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 5),
            detailsButton.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 5)
            ])
    }
    
    func SetupWikiButton(){
        containerView.addSubview(wikiButton)
        
        NSLayoutConstraint.activate([
            wikiButton.topAnchor.constraint(equalTo: detailsButton.bottomAnchor, constant: 5),
            wikiButton.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 5)
            ])
    }
    
    func SetupComicsButton(){
        containerView.addSubview(comicsButton)
        
        NSLayoutConstraint.activate([
            comicsButton.topAnchor.constraint(equalTo: wikiButton.bottomAnchor, constant: 5),
            comicsButton.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 5)
            ])
    }
    
    func SetupAddToTeamButton(){
        containerView.addSubview(addToTeamButton)
        
        NSLayoutConstraint.activate([
            addToTeamButton.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 5),
            addToTeamButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
            ])
    }
    
    func SetupDetailsTableView(){
        view.addSubview(detailsTableView)
        
        NSLayoutConstraint.activate([
            detailsTableView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            detailsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            detailsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }

    func SetupComicCollection(){

        detailsTableView.register(ComicCollectionTableViewCell.self, forCellReuseIdentifier: "ComicCollectionTableViewCell")
        
    }
    
    func SetupCharacterStatsCollection(){
        
        detailsTableView.register(CharacterStatsTableViewCell.self, forCellReuseIdentifier: "CharacterStatsTableViewCell")
    }

    @objc func faveButtonTapped(_ sender: Any) {
        if(!faved){
            faved = viewModel.saveComicToFaves(with: viewModel.comic)
        }
        else{
            faved = !viewModel.deleteComicFromFaves(with: viewModel.comic)
        }
    }
    
    @objc func detailsButtonTapped(_ sender: Any) {
        for items in viewModel.character.urls{
            if items.type.lowercased() == "detail"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func wikiButtonTapped(_ sender: Any) {
        for items in viewModel.character.urls{
            if items.type.lowercased() == "wiki"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func comicsButtonTapped(_ sender: Any) {
        for items in viewModel.character.urls{
            if items.type.lowercased() == "comiclink"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func addToTeamButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Select stats for character", message: "Only character stats with complete data is useable.", preferredStyle: .alert)
        //var bChar = BattleCharacter()
        
        for c in viewModel.characterStats{
            alert.addAction(UIAlertAction(title: c.name + String(format: ", PL: %.2f", BattleCharacter.powerLevel(c)), style: .default, handler: {(alert: UIAlertAction!) in
                let combinedID = String(self.viewModel.character.id) + ";" + c.id
                let bChar = BattleCharacter(id: (combinedID), name: c.name, image: self.viewModel.character.image, stats: Dictionary<String, Float>())
                self.viewModel.AddBattleCharacterToTeam(bChar, Constants.CoreBattleTeamKeys.DefaultBattleTeam1Name.rawValue)
                //TODO: User selected team names
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}

//MARK: Table view

extension CharacterDetailsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.bounds.height * 0.6 > 340{
            return tableView.bounds.height * 0.6
        }else {return 340}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "\(viewModel.character.name) Comics"
        case 1:
            return "\(viewModel.character.name) Stats"
        default:
            return "Section"
        }
    }
}

extension CharacterDetailsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComicCollectionTableViewCell", for: indexPath) as! ComicCollectionTableViewCell
            cell.viewModel = self.viewModel
            cell.vcIdentifier = identifier
            cell.delegate = self
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterStatsTableViewCell", for: indexPath) as! CharacterStatsTableViewCell
            cell.viewModel = self.viewModel
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}

extension CharacterDetailsViewController: ComicCollectionTableViewCellDelegate{
    func pushToNavigationController(for comic: Comic) {
        
        let detailsVC = ComicDetailsViewController()
        detailsVC.viewModel = viewModel
        viewModel.comic = comic
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}
