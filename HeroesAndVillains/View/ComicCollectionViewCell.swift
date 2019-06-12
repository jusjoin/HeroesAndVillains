//
//  ComicCollectionViewCell.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/10/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with comic: Comic) {
        
        //comicImageView.image =
        comicTitleLabel.text = comic.title
        
        if comic.image == Constants.Keys.defaultComicImage.rawValue{
            self.comicImageView.image = UIImage(named: Constants.Keys.defaultComicImage.rawValue)
        }else{
        let url = comic.image

        
        dlManager.download(url) { [unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)
                self.comicImageView.image = image
            }
        }
        }
    }
}

