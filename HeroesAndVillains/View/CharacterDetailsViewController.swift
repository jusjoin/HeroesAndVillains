//
//  CharacterDetailsViewController.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/10/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var faveButton: UIButton!
    
    var viewModel : ViewModel!
    let identifier = Constants.Keys.characterDetailsVCIdentifier.rawValue
    
    var faved = false{ // move to viewModel
        didSet{
            if faved == true{
                let origImage = UIImage(named: "fave-filled.png")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                faveButton.setImage(tintedImage, for: .normal)
                faveButton.tintColor = .yellow
                //faveButton.setImage(UIImage.init(named: "fave-filled.png"), for: .normal)
            }else{
                let origImage = UIImage(named: "fave.png")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                faveButton.setImage(tintedImage, for: .normal)
                faveButton.tintColor = .blue
            }
        }
    }
    @IBAction func faveButtonTapped(_ sender: Any) {
        if(!faved){
            faved = viewModel.saveCharacterToFaves(with: viewModel.character)
        }
        else{
            faved = !viewModel.deleteCharacterFromFaves(with: viewModel.character)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCharacter()
        setupComicCollection()
        setupCharacterStatsCollection()
    }
    
    func setupCharacter(){
         dlManager.download(viewModel.character.image){[unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)
                self.characterImageView.image = image
            }
        }
        characterNameLabel.text = viewModel.character.name
        print(viewModel.character.description)
        characterDescriptionLabel.text = viewModel.character.description
        faved = viewModel.CheckFavedCharacters(with: viewModel.character)
        
    }

    func setupComicCollection(){

        detailsTableView.tableFooterView = UIView(frame: .zero)
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(UINib.init(nibName: "ComicCollectionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ComicCollectionTableViewCell")
        
    }
    
    func setupCharacterStatsCollection(){
        
        detailsTableView.register(UINib.init(nibName: "CharacterStatsTableCell", bundle: Bundle.main), forCellReuseIdentifier: "CharacterStatsTableCell")
    }

    @IBAction func detailsButtonTapped(_ sender: Any) {
        for items in viewModel.character.urls{
            if items.type.lowercased() == "detail"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
    
    @IBAction func wikiButtonTapped(_ sender: Any) {
        for items in viewModel.character.urls{
            if items.type.lowercased() == "wiki"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
    
    @IBAction func comicsButtonTapped(_ sender: Any) {
        for items in viewModel.character.urls{
            if items.type.lowercased() == "comiclink"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
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
            cell.viewModel = self.viewModel
            cell.vcIdentifier = identifier
            
            //        let thisCharacter = viewModel.characters[indexPath.row]
            //        cell.configure(with: aCharacter(with: thisCharacter))
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterStatsTableCell", for: indexPath) as! CharacterStatsTableCell
            cell.viewModel = self.viewModel
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
