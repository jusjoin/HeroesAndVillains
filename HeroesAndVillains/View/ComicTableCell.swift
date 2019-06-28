//
//  ComicTableCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/26/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class ComicTableCell: UITableViewCell {

    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicNameLabel: UILabel!
    @IBOutlet weak var comicDescriptionLabel: UILabel!
    
    static let identifier = "ComicTableCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        comicDescriptionLabel.numberOfLines = 2
    }
    
    func configure(with comic: Comic) {
        comicNameLabel.text = comic.title
        let strDesc = comic.description.stripHTML()
        comicDescriptionLabel.text = strDesc
        // characterImage.image = UIImage(named: "mask.png")
        
        dlManager.download(comic.image) { [unowned self] dat in
            if let data = dat {
                let image = UIImage(data: data)
                self.comicImage.image = image
            }
        }
        
    }
}
