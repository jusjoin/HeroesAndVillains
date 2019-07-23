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
    lazy var characterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        let collectionView =
            UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var viewModel : ViewModel!
    var delegate: CharacterCollectionTableViewCellDelegate?
    var vcIdentifier: String?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func commonInit() {
        //setupCharacterCollection()
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterCollection), name: Notification.Name.CharactersForNotification, object: nil)
        
        addSubview(characterCollectionView)
        NSLayoutConstraint.activate([
            characterCollectionView.topAnchor.constraint(equalTo: topAnchor),
            characterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            //characterCollectionView.heightAnchor.constraint(equalTo: heightAnchor),
            //characterCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            characterCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
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
            self.characterCollectionView.reloadData()
        }
    }

}

extension CharacterCollectionTableViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: frame.width * 0.5, height: frame.height)
        print(size)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        delegate?.pushToNavigationController(for: aCharacter(with: viewModel.comicCharacters[indexPath.row]))
    }
}

extension CharacterCollectionTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.comicCharacters.count
        //check for correct variable
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = characterCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath as IndexPath) as! CharacterCollectionViewCell
        
        let thisCharacter = viewModel.comicCharacters[indexPath.row]
        cell.configure(with: aCharacter(with: thisCharacter))
        return cell
    }
    
    
}
