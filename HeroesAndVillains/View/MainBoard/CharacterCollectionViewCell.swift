//
//  CharacterCollectionViewCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/15/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with character: aCharacter) {
        
        //comicImageView.image =
        characterNameLabel.text = character.name
        
        if character.image == Constants.Keys.defaultComicImage.rawValue{
            self.characterImageView.image = UIImage(named: Constants.Keys.defaultComicImage.rawValue)
        }else{
            let url = character.image
            
            
            dlManager.download(url) { [unowned self] dat in
                
                if let data = dat {
                    
                    let image = UIImage(data: data)
                    self.characterImageView.image = image
                }
            }
        }
    }
}

