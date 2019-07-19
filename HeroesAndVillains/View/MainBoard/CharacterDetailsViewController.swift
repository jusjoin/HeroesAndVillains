//
//  CharacterDetailsViewController.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/10/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    lazy var containerView : UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        //label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    lazy var characterDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        //label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    lazy var faveButton: UIButton = {
        let button = UIButton()
        let origImage = UIImage(named: "favorites")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .yellow
        return button
    }()
    
    lazy var detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Details", for: .normal)
        button.tintColor = .blue
        return button
    }()
    
    lazy var wikiButton: UIButton = {
        let button = UIButton()
        button.setTitle("Wiki", for: .normal)
        button.tintColor = .blue
        return button
    }()
    
    lazy var comicsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Comics", for: .normal)
        button.tintColor = .blue
        return button
    }()
    
    lazy var addToTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add To Team", for: .normal)
        button.tintColor = .blue
        return button
    }()
    
    lazy var detailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComicCollectionTableViewCell.self, forCellReuseIdentifier: "ComicCollectionTableViewCell")
        tableView.register(VideoCollectionTableViewCell.self, forCellReuseIdentifier: "CharacterStatsTableViewCell")
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
        setupCharacterImageView()
        setupComicCollection()
        setupCharacterStatsCollection()
    }
    
    func setupContainerView(){
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
    }
    
    func setupCharacterImageView(){
        dlManager.download(viewModel.character.image){[unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)
                self.characterImageView.image = image
            }
        }
        
        print(viewModel.character.description)
        
        faved = viewModel.isFaved(viewModel.character)
        
    }
    
    func setupCharacterNameLabel(){
        characterNameLabel.text = viewModel.character.name
    }
    
    func setupCharacterDescriptionLabel(){
        characterDescriptionLabel.text = viewModel.character.description
    }
    
    func setupDetailsButton(){
        
    }
    
    func setupWikiButton(){
        
    }
    
    func setupComicsButton(){
        
    }
    
    func setupAddToTeamButton(){
        
    }
    
    func setupDetailsTableView(){
        view.addSubview(detailsTableView)
        
        NSLayoutConstraint.activate([
            detailsTableView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            detailsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65),
            
            detailsTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            detailsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }

    func setupComicCollection(){

        detailsTableView.tableFooterView = UIView(frame: .zero)
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(UINib.init(nibName: "ComicCollectionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ComicCollectionTableViewCell")
        
    }
    
    func setupCharacterStatsCollection(){
        
        detailsTableView.register(UINib.init(nibName: "CharacterStatsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CharacterStatsTableViewCell")
    }

    func faveButtonTapped(_ sender: Any) {
        if(!faved){
            faved = viewModel.saveComicToFaves(with: viewModel.comic)
        }
        else{
            faved = !viewModel.deleteComicFromFaves(with: viewModel.comic)
        }
    }
    
    func detailsButtonTapped(_ sender: Any) {
        for items in viewModel.character.urls{
            if items.type.lowercased() == "detail"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
    
    func wikiButtonTapped(_ sender: Any) {
        for items in viewModel.character.urls{
            if items.type.lowercased() == "wiki"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
    
    func comicsButtonTapped(_ sender: Any) {
        for items in viewModel.character.urls{
            if items.type.lowercased() == "comiclink"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
    
    func addToTeamButtonTapped(_ sender: Any) {
        
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
            //setupComicCollection()
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComicCollectionTableViewCell", for: indexPath) as! ComicCollectionTableViewCell
            cell.vcIdentifier = identifier
            cell.viewModel = self.viewModel
            cell.delegate = self
            
            //        let thisCharacter = viewModel.characters[indexPath.row]
            //        cell.configure(with: aCharacter(with: thisCharacter))
            
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
        
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "ComicDetailsViewController") as! ComicDetailsViewController
        viewModel.comic = comic
        detailsVC.viewModel = viewModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}
