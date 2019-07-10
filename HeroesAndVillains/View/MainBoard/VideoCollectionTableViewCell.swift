//
//  VideoCollectionTableViewCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/16/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit
import AVKit

protocol VideoCollectionTableViewCellDelegate{
    func presentPlayer(for player: AVPlayer)
}

class VideoCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var VideoCollectionView: UICollectionView!
    
    
    var viewModel: ViewModel!
    var delegate: VideoCollectionTableViewCellDelegate?
    var vcIdentifier: String?{
        didSet{
            setupVideoCollection()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.VideoCollectionView.dataSource = self
        self.VideoCollectionView.delegate = self
        self.VideoCollectionView.register(UINib.init(nibName: "VideoCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "VideoCollectionViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(updateVideoCollection), name: Notification.Name.VideosNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateVideoCollection), name: Notification.Name.VideosForNotification, object: nil)
    }
    
    @objc func updateVideoCollection(){
        DispatchQueue.main.async{
            self.VideoCollectionView.reloadData()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupVideoCollection(){
        
        if vcIdentifier == Constants.Keys.homeVCIdentifier.rawValue{
            viewModel.getFeaturedVideos()
        }else if vcIdentifier == Constants.Keys.characterDetailsVCIdentifier.rawValue{
            //viewModel.getFeaturedVideosFor(for: viewModel.character.id, dateDescriptor: comicPeriodDateDescriptor, forDate1: comicPeriodDate1, forDate2: comicPeriodDate2)
        }
    }
    
}

extension VideoCollectionTableViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 320, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let video = viewModel.featuredVideos[indexPath.row].lowURL
        let videoURL = URL(string: video!)!
        let player = AVPlayer(url: videoURL)
        
        delegate?.presentPlayer(for: player)
    }
}


extension VideoCollectionTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if vcIdentifier == Constants.Keys.homeVCIdentifier.rawValue{
//            return viewModel.comics.count
//        }else if vcIdentifier == Constants.Keys.characterDetailsVCIdentifier.rawValue{
//            return viewModel.characterComics.count
//        }
        
        return viewModel.featuredVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = VideoCollectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath as IndexPath) as! VideoCollectionViewCell
        
//        if vcIdentifier == Constants.Keys.homeVCIdentifier.rawValue{
//            let thisComic = viewModel.comics[indexPath.row]
//            cell.configure(with: Comic(with: thisComic))
//            return cell
//        }else if vcIdentifier == Constants.Keys.characterDetailsVCIdentifier.rawValue{
//            let thisComic = viewModel.characterComics[indexPath.row]
//            cell.configure(with: Comic(with: thisComic))
//            return cell
//        }
        
        let thisVideo = viewModel.featuredVideos[indexPath.row]
        cell.configure(with: thisVideo)
        return cell
    }
    
    
}
