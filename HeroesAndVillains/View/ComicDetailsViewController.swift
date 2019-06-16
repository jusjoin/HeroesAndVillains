//
//  ComicDetailsViewContriollerViewController.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/15/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class ComicDetailsViewController: UIViewController {
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicNameLabel: UILabel!
    @IBOutlet weak var comicDescriptionLabel: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    
    var viewModel : ViewModel!
    let identifier = "ComicDetailsViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupComic()
        setupCharacterCollection()
    }
    
    func setupComic(){
        dlManager.download(viewModel.comic.image){[unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)
                self.comicImageView.image = image
            }
        }
        comicNameLabel.text = viewModel.comic.title
        comicDescriptionLabel.text = viewModel.comic.description
    }
    
    func setupCharacterCollection(){
        
        detailsTableView.tableFooterView = UIView(frame: .zero)
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(UINib.init(nibName: "CharacterCollectionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CharacterCollectionTableViewCell")
        
    }


}

//MARK: Table view

extension ComicDetailsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {return "\(viewModel.comic.title) Characters"}
        
        return "Section"
    }
}

extension ComicDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //setupComicCollection()
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCollectionTableViewCell", for: indexPath) as! CharacterCollectionTableViewCell
        cell.viewModel = self.viewModel
        cell.vcIdentifier = identifier
        
        //        let thisCharacter = viewModel.characters[indexPath.row]
        //        cell.configure(with: aCharacter(with: thisCharacter))
        
        return cell
    }
    
    
}
