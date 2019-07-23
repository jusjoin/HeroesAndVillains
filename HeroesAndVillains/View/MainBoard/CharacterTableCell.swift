//
//  CharacterTableCell.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class CharacterTableCell: UITableViewCell {
    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
//        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    lazy var characterDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
//        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    static let identifier = "CharacterTableCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CommonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CharacterTableCell.identifier)
        CommonInit()
    }
    
    func CommonInit(){
        SetupImageView()
        SetupNameLabel()
        SetupDescriptionLabel()
    }
    
    func SetupImageView(){
        addSubview(characterImageView)
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImageView.topAnchor.constraint(equalTo: topAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            characterImageView.heightAnchor.constraint(equalTo: heightAnchor),
            characterImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25)
            ])
    }
    
    func SetupNameLabel(){
        addSubview(characterNameLabel)
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 5),
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.topAnchor)
//            characterNameLabel.bottomAnchor.constraint(equalTo: characterImageView.top),
            //characterNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
//            characterNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25)
            ])
    }
    
    func SetupDescriptionLabel(){
        addSubview(characterDescriptionLabel)
        characterDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterDescriptionLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 5),
            characterDescriptionLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor),
            characterDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            characterDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            
            ])
    }
    
    func configure(with char: aCharacter) {
        characterNameLabel.text = char.name
        characterDescriptionLabel.text = char.description
        // characterImage.image = UIImage(named: "mask.png")
        
        dlManager.download(char.image) { [unowned self] dat in
            if let data = dat {
                let image = UIImage(data: data)
                self.characterImageView.image = image
            }
        }
 
    }
}
