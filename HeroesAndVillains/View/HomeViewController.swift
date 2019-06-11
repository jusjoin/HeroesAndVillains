//
//  ViewController.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/3/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.Keys.homeTitle.rawValue
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        setupCollection()
        //searchTableView.tableFooterView = UIView(frame: .zero)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollection), name: Notification.Name.TopCharacterNotification, object: nil)
        
    }
    
    func setupCollection(){
    
        viewModel.getTopCharacters()
    }
    
    @objc func updateCollection(){
        DispatchQueue.main.async{
            self.characterCollectionView.reloadData()
        }
    }


}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 175, height: 194)
    }
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionCell.identifier, for: indexPath) as! CharacterCollectionCell
        
        let thisCharacter = viewModel.topCharacters[indexPath.row]
        cell.configure(with: aCharacter(with: thisCharacter))
        
        return cell
    }
    
    
    
}
