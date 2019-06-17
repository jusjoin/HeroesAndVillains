//
//  VideoCollectionViewCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/16/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var videoImageVIew: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with video: CVideo) {
        
        //comicImageView.image =
        videoTitleLabel.text = video.name
        
        if video.image["medium_url"] == Constants.Keys.defaultComicImage.rawValue{
            self.videoImageVIew.image = UIImage(named: Constants.Keys.defaultComicImage.rawValue)
        }else{
            let url = video.image["medium_url"]!
            
            
            dlManager.download(url!) { [unowned self] dat in
                
                if let data = dat {
                    
                    let image = UIImage(data: data)
                    self.videoImageVIew.image = image
                }
            }
        }
    }

}
