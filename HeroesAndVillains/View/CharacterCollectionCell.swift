//
//  CharacterCollectionCell.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/6/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class CharacterCollectionCell: UICollectionViewCell {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    let viewModel = ViewModel()
    static let identifier = "CharacterCollectionCell"
    
    func configure(with char: aCharacter){
        
        characterNameLabel.text = char.name
        
        dlManager.download(char.image) { [unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)
                self.characterImageView.image = image
            }
        }
        
    }
}


