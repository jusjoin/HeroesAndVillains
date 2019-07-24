//
//  CharacterCollectionCell.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/6/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class CharacterCollectionCell: UICollectionViewCell {
    var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
//        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    var faveButton: UIButton = {
        let button = UIButton()
        let origImage = UIImage(named: "favorites")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .blue

        return button
    }()
    
    var thisCharacter: aCharacter!
    static let identifier = "CharacterCollectionCell"
    
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
        addSubview(faveButton)
        addSubview(characterNameLabel)
        faveButton.addTarget(self, action: #selector(faveButtonTapped(_:)), for: .touchUpInside)
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        characterImageView.bottomAnchor.constraint(equalTo: characterNameLabel.topAnchor, constant: -8).isActive = true
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false

        
        characterNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        characterNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        characterNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        characterNameLabel.widthAnchor.constraint(equalTo: characterImageView.widthAnchor).isActive = true
        
        
        faveButton.translatesAutoresizingMaskIntoConstraints = false
        faveButton.bottomAnchor.constraint(equalTo: characterImageView.topAnchor, constant: 35).isActive = true
        
        faveButton.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor, constant: 5).isActive = true
        
        faveButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
        
        faveButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        //faveButton.backgroundColor = .yellow
    }
    
    var faved = false{ // move to viewModel
        didSet{
            if faved == true{
                let origImage = UIImage(named: "favorites-filled")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                faveButton.setImage(tintedImage, for: .normal)
                faveButton.tintColor = .yellow
            }else{
                let origImage = UIImage(named: "favorites")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                faveButton.setImage(tintedImage, for: .normal)
                faveButton.tintColor = .blue
            }
        }
    }
    
    
    func configure(with char: aCharacter){
        thisCharacter = char

        dlManager.download(char.image) { [unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)

                self.setupImageView(image: image!)
            }
        }
        setupLabel(name: char.name)
        print(char.name)
        setupFavoritesButton()
        faved = ViewModel.isFaved(char)
    }
    
    
    @objc func faveButtonTapped(_ sender: UIButton) {
        print("Fave button tapped")
        if(!faved){
            faved = ViewModel.saveCharacterToFaves(with: thisCharacter)
        }
        else{
            faved = !ViewModel.deleteCharacterFromFaves(with: thisCharacter)
        }
    }
    
    func setupImageView(image: UIImage){
        characterImageView.image = image
    }
    
    func setupLabel(name: String){
        characterNameLabel.text = name
    }
    
    func setupFavoritesButton(){
        // TODO: - customtization
        print("stop")
    }
    
}

