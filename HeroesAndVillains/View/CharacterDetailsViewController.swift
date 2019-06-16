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
    
    var viewModel : ViewModel!
    let identifier = Constants.Keys.characterDetailsVCIdentifier.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCharacter()
        setupComicCollection()
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
    }

    func setupComicCollection(){

        detailsTableView.tableFooterView = UIView(frame: .zero)
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(UINib.init(nibName: "ComicCollectionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ComicCollectionTableViewCell")
        
    }

}

//MARK: Table view

extension CharacterDetailsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {return "\(viewModel.character.name) Comics"}
        
        return "Section"
    }
}

extension CharacterDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //setupComicCollection() 
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicCollectionTableViewCell", for: indexPath) as! ComicCollectionTableViewCell
        cell.viewModel = self.viewModel
        cell.vcIdentifier = identifier

        //        let thisCharacter = viewModel.characters[indexPath.row]
        //        cell.configure(with: aCharacter(with: thisCharacter))
        
        return cell
    }
    
    
}
