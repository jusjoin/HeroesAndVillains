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
    @IBOutlet weak var characterDescriptionTextField: UITextView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    var viewModel : ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func setupComicCollection(){
        detailsTableView.register(UINib(nibName: "ComicColectionViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ComicColectionViewCell")
        detailsTableView.tableFooterView = UIView(frame: .zero)
        viewModel.getComicsForCharacter()
    }

}

//MARK: Table view

//extension CharacterDetailsViewController: UITableViewDelegate{
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.tracks.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableCell.identifier, for: indexPath) as! ContentTableCell
//        
//        cell.backgroundColor = .clear
//        
//        let track = viewModel.tracks[indexPath.row]
//        let content = Content.track(track)
//        cell.configure(with: content)
//        
//        return cell
//    }
//}
//
//extension CharacterDetailsViewController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    
//    
//}

//MARK: Collection view

extension CharacterDetailsViewController: UICollectionViewDelegateFlowLayout{
    
}
