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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
//        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    var faveButton: UIButton = {
        let button = UIButton()
        let origImage = UIImage(named: "favorites")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .yellow
        //button.addTarget(self, action: #selector(faveButtonTapped), for: .touchUpInside) // why is this ignored?
        return button
    }()
    
    var viewModel: ViewModel!
    static let identifier = "CharacterCollectionCell"
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
        characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        //  characterImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        
        characterImageView.bottomAnchor.constraint(equalTo: characterNameLabel.topAnchor, constant: -8).isActive = true
        // characterImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95).isActive = true
        //characterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70).isActive = true
        
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        // characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 8).isActive = true
        
        characterNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        // characterImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95).isActive = true
        
        characterNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        characterNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        characterNameLabel.widthAnchor.constraint(equalTo: characterImageView.widthAnchor) //Why doesn't this constrain label to image width
        
        
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
                //faveButton.setImage(UIImage.init(named: "fave-filled.png"), for: .normal)
            }else{
                let origImage = UIImage(named: "favorites")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                faveButton.setImage(tintedImage, for: .normal)
                faveButton.tintColor = .yellow
            }
        }
    }
    
    
    func configure(with char: aCharacter){
        viewModel.character = char
        //characterNameLabel.text = char.name
        //characterImageView.image = UIImage(named: char.image)
        dlManager.download(char.image) { [unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)
//                self.characterImageView.image = image
                self.setupImageView(image: image!)
            }
        }
        setupLabel(name: char.name)
        setupFavoritesButton()
        //faved = viewModel.CheckFavedCharacters(with: char) //configure being called on every scroll or appear is this normal?
        faved = viewModel.isFaved(char)
    }
    
    
    @objc func faveButtonTapped(_ sender: UIButton) {
        print("Fave button tapped")
        if(!faved){
            faved = viewModel.saveCharacterToFaves(with: viewModel.character)
        }
        else{
            faved = !viewModel.deleteCharacterFromFaves(with: viewModel.character)
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

