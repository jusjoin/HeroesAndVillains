//
//  HeroStatsTableCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/28/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class CharacterStatsTableCell: UITableViewCell {
    @IBOutlet weak var CharacterStatsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        CharacterStatsCollectionView.delegate = self
        CharacterStatsCollectionView.dataSource = self
        
        self.CharacterStatsCollectionView.register(UINib.init(nibName: "CharacterStatsCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CharacterStatsCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CharacterStatsTableCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: 320, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        //delegate?.pushToNavigationController(for: Comic(with: viewModel.comics[indexPath.row]))
    }
    
}

extension CharacterStatsTableCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = CharacterStatsCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterStatsCollectionCell", for: indexPath as IndexPath) as! CharacterStatsCollectionCell
        
        return cell
    }
    
    
}
