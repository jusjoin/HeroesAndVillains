//
//  ComicCollectionViewCell.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/10/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {
    var comicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    var comicTitleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        
        return label
    }()
    
    static let identifier = "ComicCollectionViewCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        addSubview(comicImageView)
        addSubview(comicTitleLabel)
        
        //faveButton.addTarget(self, action: #selector(faveButtonTapped(_:)), for: .touchUpInside)
        
        comicImageView.translatesAutoresizingMaskIntoConstraints = false
        comicImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true

        comicImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        comicImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        
        comicImageView.bottomAnchor.constraint(equalTo: comicTitleLabel.topAnchor, constant: -8).isActive = true
        
        comicTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        
        comicTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        
        comicTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        comicTitleLabel.widthAnchor.constraint(equalTo: comicImageView.widthAnchor).isActive = true
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
                //BUG random crahses happen here if scrolling too quickly due to images being deallocated while scrolling
            }
        }
        }
    }
}

