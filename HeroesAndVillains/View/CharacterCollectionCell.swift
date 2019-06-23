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
    @IBOutlet weak var faveButton: UIButton!
    
    let viewModel = ViewModel()
    static let identifier = "CharacterCollectionCell"
    
    var faved = false{ // move to viewModel
        didSet{
            if faved == true{
                let origImage = UIImage(named: "fave-filled.png")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                faveButton.setImage(tintedImage, for: .normal)
                faveButton.tintColor = .yellow
                //faveButton.setImage(UIImage.init(named: "fave-filled.png"), for: .normal)
            }else{
                let origImage = UIImage(named: "fave.png")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                faveButton.setImage(tintedImage, for: .normal)
                faveButton.tintColor = .blue
            }
        }
    }
    
    func configure(with char: aCharacter){
        
        viewModel.character = char
        characterNameLabel.text = char.name
        faved = viewModel.CheckFavedCharacters(with: char)
        characterImageView.image = UIImage(named: char.image)
        dlManager.download(char.image) { [unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)
                self.characterImageView.image = image
            }
        }
        
    }
    
    
    @IBAction func faveButtonTapped(_ sender: Any) {
        
        if(!faved){
            faved = viewModel.saveCharacterToFaves(with: viewModel.character)
        }
        else{
            faved = !viewModel.deleteCharacterFromFaves(with: viewModel.character)
        }
    }
}


