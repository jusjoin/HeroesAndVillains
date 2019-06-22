//
//  CharacterCollectionTableViewCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/15/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

protocol CharacterCollectionTableViewCellDelegate{
    func pushToNavigationController(for character: aCharacter)
}

class CharacterCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var CharacterCollectionView: UICollectionView!
    
    var viewModel : ViewModel!
    var delegate: CharacterCollectionTableViewCellDelegate?
    var vcIdentifier: String?{
        didSet{
            setupCharacterCollection()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.CharacterCollectionView.dataSource = self
        self.CharacterCollectionView.delegate = self
        self.CharacterCollectionView.register(UINib.init(nibName: "CharacterCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterCollection), name: Notification.Name.CharactersForNotification, object: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCharacterCollection(){
        if(viewModel != nil){
            if !viewModel.comicCharacters.isEmpty{
                viewModel.comicCharacters.removeAll()
            }
        }
        viewModel.getCharactersForComic(for: viewModel.comic.id)
        
    }
    
    @objc func updateCharacterCollection(){
        DispatchQueue.main.async{
            self.CharacterCollectionView.reloadData()
        }
    }

}

extension CharacterCollectionTableViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 160, height: 176)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        delegate?.pushToNavigationController(for: aCharacter(with: viewModel.characters[indexPath.row]))
    }
}

extension CharacterCollectionTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.comicCharacters.count
        //check for correct variable
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = CharacterCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath as IndexPath) as! CharacterCollectionViewCell
        
        let thisCharacter = viewModel.comicCharacters[indexPath.row]
        cell.configure(with: aCharacter(with: thisCharacter))
        return cell
    }
    
    
}
