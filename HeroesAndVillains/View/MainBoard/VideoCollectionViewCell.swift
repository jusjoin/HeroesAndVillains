//
//  VideoCollectionViewCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/16/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    lazy var videoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    lazy var videoTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        
        return label
    }()
    
    static let identifier = "VideoCollectionViewCell"
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        addSubview(videoImageView)
        addSubview(videoTitleLabel)
        
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        videoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        videoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        
        videoImageView.bottomAnchor.constraint(equalTo: videoTitleLabel.topAnchor, constant: -8).isActive = true
        
        videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        videoTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        videoTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoTitleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
    }
    
    func configure(with video: CVideo) {
        
        //comicImageView.image =
        videoTitleLabel.text = video.name
        
        if video.image["medium_url"] == Constants.Keys.defaultComicImage.rawValue{
            self.videoImageView.image = UIImage(named: Constants.Keys.defaultComicImage.rawValue)
        }else{
            let url = video.image["medium_url"]!
            
            
            dlManager.download(url!) { [unowned self] dat in
                
                if let data = dat {
                    
                    let image = UIImage(data: data)
                    self.videoImageView.image = image
                }
            }
        }
    }

}
