//
//  CharacterTableCell.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class CharacterTableCell: UITableViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    static let identifier = "CharacterTableCell"
    
    func configure(with char: aCharacter) {
        characterNameLabel.text = char.name
        characterDescriptionLabel.text = char.description
        dlManager.download(char.image) { [unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)
                self.characterImage.image = image
            }
        }
    }
    

    
    
}
