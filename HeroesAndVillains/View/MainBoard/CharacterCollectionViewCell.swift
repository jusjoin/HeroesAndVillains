//
//  CharacterCollectionViewCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/15/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        
        return label
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        
        addSubview(characterImageView)
        addSubview(characterNameLabel)
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        
        characterImageView.bottomAnchor.constraint(equalTo: characterNameLabel.topAnchor, constant: -8).isActive = true
        
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        characterNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        characterNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        characterNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        characterNameLabel.widthAnchor.constraint(equalTo: characterImageView.widthAnchor).isActive = true
        
    }
    
    
    func configure(with character: aCharacter) {
        
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

