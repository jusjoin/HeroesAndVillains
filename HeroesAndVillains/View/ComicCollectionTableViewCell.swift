//
//  ComicCollectionTableViewCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/12/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class ComicCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var ComicCollectionView: UICollectionView!
    
    let viewModel = ViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.ComicCollectionView.dataSource = self
        self.ComicCollectionView.delegate = self
        self.ComicCollectionView.register(UINib.init(nibName: "ComicCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ComicCollectionViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(updateComicCollection), name: Notification.Name.ComicsNotification, object: nil)
        
        setupComicCollection()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupComicCollection(){
        
        viewModel.getComics()
    }
    
    @objc func updateComicCollection(){
        DispatchQueue.main.async{
            self.ComicCollectionView.reloadData()
        }
    }
    
}

extension ComicCollectionTableViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 160, height: 176)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
//        let index = IndexPath(row: indexPath.row, section: 1)
//        searchTableView.scrollToRow(at: index, at: .top, animated: true)
    }
}

extension ComicCollectionTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ComicCollectionView.dequeueReusableCell(withReuseIdentifier: "ComicCollectionViewCell", for: indexPath as IndexPath) as! ComicCollectionViewCell
        
        let thisComic = viewModel.comics[indexPath.row]
        cell.configure(with: Comic(with: thisComic))
        return cell
        
    }
    
    
}
