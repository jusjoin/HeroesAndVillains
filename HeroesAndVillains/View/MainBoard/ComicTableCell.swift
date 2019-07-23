//
//  ComicTableCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/26/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class ComicTableCell: UITableViewCell {

    lazy var comicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var comicNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        //        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var comicDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        //        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    static let identifier = "ComicTableCell"
    
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
        addSubview(comicImageView)
        comicImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            comicImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            comicImageView.topAnchor.constraint(equalTo: topAnchor),
            comicImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            comicImageView.heightAnchor.constraint(equalTo: heightAnchor),
            comicImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25)
            ])
    }
    
    func SetupNameLabel(){
        addSubview(comicNameLabel)
        comicNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            comicNameLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 5),
            comicNameLabel.topAnchor.constraint(equalTo: comicImageView.topAnchor)
            ])
    }
    
    func SetupDescriptionLabel(){
        addSubview(comicDescriptionLabel)
        comicDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            comicDescriptionLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 5),
            comicDescriptionLabel.topAnchor.constraint(equalTo: comicNameLabel.bottomAnchor),
            comicDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            comicDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            
            ])
    }
    
    func configure(with comic: Comic) {
        comicNameLabel.text = comic.title
        let strDesc = comic.description.stripHTML()
        comicDescriptionLabel.text = strDesc
        // characterImage.image = UIImage(named: "mask.png")
        
        dlManager.download(comic.image) { [unowned self] dat in
            if let data = dat {
                let image = UIImage(data: data)
                self.comicImageView.image = image
            }
        }
        
    }
}
