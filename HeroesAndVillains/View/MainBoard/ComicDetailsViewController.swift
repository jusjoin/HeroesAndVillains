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
    @IBOutlet weak var comicPrice: UILabel!
    @IBOutlet weak var comicCreators: UILabel!
    @IBOutlet weak var faveButton: UIButton!
    
    var viewModel : ViewModel!
    let identifier = "ComicDetailsViewController"
    
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
            faved = viewModel.saveComicToFaves(with: viewModel.comic)
        }
        else{
            faved = !viewModel.deleteComicFromFaves(with: viewModel.comic)
        }
    }
    
    
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
        comicDescriptionLabel.text = viewModel.comic.description.stripHTML()
        comicPrice.text = String(viewModel.comic.price)
        comicCreators.text = viewModel.comic.creators
        faved = viewModel.CheckFavedComics(with: viewModel.comic)
    }
    
    func setupCharacterCollection(){
        
        detailsTableView.tableFooterView = UIView(frame: .zero)
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(UINib.init(nibName: "CharacterCollectionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CharacterCollectionTableViewCell")
        
    }

    @IBAction func detailsButtonTapped(_ sender: Any) {
        for items in viewModel.comic.urls{
            if items.type.lowercased() == "detail"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
    
    @IBAction func purchaseButtonTapped(_ sender: Any) {
        for items in viewModel.comic.urls{
            if items.type.lowercased() == "purchase"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
}

//MARK: Table view

extension ComicDetailsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.bounds.height * 0.6 > 340{
            return tableView.bounds.height * 0.6
        }else {return 340}
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
        cell.delegate = self
        
        //        let thisCharacter = viewModel.characters[indexPath.row]
        //        cell.configure(with: aCharacter(with: thisCharacter))
        
        return cell
    }
    
    
}

extension ComicDetailsViewController: CharacterCollectionTableViewCellDelegate{
    func pushToNavigationController(for character: aCharacter) {
        
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
        viewModel.character = character
        detailsVC.viewModel = viewModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}
