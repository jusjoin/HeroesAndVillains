//
//  HeroStatsTableCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/28/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class CharacterStatsTableViewCell: UITableViewCell {
    lazy var characterStatsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        let collectionView =
            UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    var characterStats: [CharacterStats]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func commonInit() {
        
        setupCollectionView()
    }
    
    func setupCollectionView(){
        
        addSubview(characterStatsCollectionView)
        characterStatsCollectionView.widthAnchor.constraint(equalTo: widthAnchor)
        characterStatsCollectionView.heightAnchor.constraint(equalTo: heightAnchor)
        characterStatsCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor)
        characterStatsCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        self.characterStatsCollectionView.register( CharacterStatsCollectionCell.self, forCellWithReuseIdentifier: "CharacterStatsCollectionCell")
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterStats), name: Notification.Name.CharacterStatsNotification, object: nil)
    }
    
    //Paging
    private var startingScrollingOffset = CGPoint.zero
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startingScrollingOffset = scrollView.contentOffset // 1
    }
    //Paging
    
//    override func layoutSubviews() {
//        viewModel.getCharacterStats(name: viewModel.character.name)
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func updateCharacterStats(){
        DispatchQueue.main.async{
            self.characterStatsCollectionView.reloadData()
        }
    }
}

extension CharacterStatsTableViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //collectionView.deselectItem(at: indexPath, animated: true)
        print("Cell selected: \(indexPath.row)")
        //delegate?.pushToNavigationController(for: Comic(with: viewModel.comics[indexPath.row]))
    }
    
}

extension CharacterStatsTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return [characterStats].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = characterStatsCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterStatsCollectionCell", for: indexPath as IndexPath) as! CharacterStatsCollectionCell
        if characterStats.count > 0{ cell.characterStats = characterStats[indexPath.row]
            cell.configure(thisCharacter: characterStats[indexPath.row])
        }
        return cell
    }
    
    
}

extension CharacterStatsTableViewCell: UICollectionViewDelegate{
    
    //Paging
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        

        let cellWidth = collectionView( // 1
            characterStatsCollectionView,
            layout: characterStatsCollectionView.collectionViewLayout,
            sizeForItemAt: IndexPath(item: 0, section: 0)
            ).width

        let page: CGFloat
        //let snapPoint: CGFloat = 0.3
        //let snapDelta: CGFloat = 1 - snapPoint
        //let proposedPage = targetContentOffset.pointee.x / max(1, cellWidth) // 2

        let offset = scrollView.contentOffset.x + scrollView.contentInset.left // 2
        let proposedPage = offset / max(1, cellWidth)
        let snapPoint: CGFloat = 0.1
        let snapDelta: CGFloat = offset > startingScrollingOffset.x ? (1 - snapPoint) : snapPoint

        if floor(proposedPage + snapDelta) == floor(proposedPage) { // 3
            page = floor(proposedPage) // 4
        }
        else {
            page = floor(proposedPage + 1) // 5
        }

        targetContentOffset.pointee = CGPoint(
            x: cellWidth * page,
            y: targetContentOffset.pointee.y
        )
//        // Stop scrollView sliding:
//        targetContentOffset.pointee = scrollView.contentOffset
//
//        let indexOfMajorCell = self.indexOfMajorCell()
//
//        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
//        CharacterStatsCollectionView.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

    }
    //Paging
}
