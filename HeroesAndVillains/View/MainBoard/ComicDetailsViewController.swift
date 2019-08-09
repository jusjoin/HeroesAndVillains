//
//  ComicDetailsViewContriollerViewController.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/15/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class ComicDetailsViewController: UIViewController {
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var comicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var comicNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        //label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var comicDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var comicPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        //label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var comicCreatorsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var faveButton: UIButton = {
        let button = UIButton()
        let origImage = UIImage(named: "favorites")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var comicDetailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Details", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var comicPurchaseButton: UIButton = {
       let button = UIButton()
        button.setTitle("Purchase", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var characterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        let collectionView =
            UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var viewModel = ComicViewModel()
    let identifier = "ComicDetailsViewController"
    
    var faved = false{ // move to viewModel
        didSet{
            if faved == true{
                let origImage = UIImage(named: "favorites-filled")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                faveButton.setImage(tintedImage, for: .normal)
                faveButton.tintColor = .yellow
                //faveButton.setImage(UIImage.init(named: "fave-filled.png"), for: .normal)
            }else{
                let origImage = UIImage(named: "favorites")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                faveButton.setImage(tintedImage, for: .normal)
                faveButton.tintColor = .blue
            }
        }
    }
    @objc func faveButtonTapped(_ sender: Any) {
        if(!faved){
            faved = viewModel.saveComicToFaves(with: viewModel.comic)
        }
        else{
            faved = !viewModel.deleteComicFromFaves(with: viewModel.comic)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    init(thisComic: Comic){
        viewModel.comic = thisComic
        super.init(nibName: nil, bundle: Bundle.main)
        commonInit()
    }
    
    func commonInit() {
        super.viewDidLoad()

        viewModel.getCharactersForComic(for: viewModel.comic.id)
        setupNavigation()
        setupObservers()
        setupContainerView()
        setupDescriptionScrollView()
        setupComicImageView()
        setupComicDescriptionLabel()
        setupFaveButton()
        setupComicNameLabel()
        setupComicPriceLabel()
        setupDetailsButton()
        setupPurchaseButton()
        setupComicCreatorsLabel()
        //setupDetailsTableView()
        setupCharacterCollection()
        
        comicDetailsButton.addTarget(self, action: #selector(detailsButtonTapped(_:)), for: .touchUpInside)
        comicPurchaseButton.addTarget(self, action: #selector(purchaseButtonTapped(_:)), for: .touchUpInside)
        faveButton.addTarget(self, action: #selector(faveButtonTapped(_:)), for: .touchUpInside)
    }
    
    func setupObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterCollection), name: Notification.Name.CharactersForNotification, object: nil)
    }
    
    func setupNavigation(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let buttonIcon = UIImage(named: "favorites")
        
        let rightBarButton = UIBarButtonItem(title: "Favorite", style: UIBarButtonItem.Style.done, target: self, action: #selector(faveButtonTapped))
        rightBarButton.image = buttonIcon
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setupContainerView(){
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            ])
        
    }
    
    func setupComicImageView(){
        
        containerView.addSubview(comicImageView)
        NSLayoutConstraint.activate([
            
            comicImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            comicImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            comicImageView.bottomAnchor.constraint(equalTo: descScrollView.topAnchor),
            comicImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5),
            comicImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4)
            
            
            ])
        
        dlManager.download(viewModel.comic.image){[unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)
                self.comicImageView.image = image
            }
        }
        
        faved = viewModel.isFaved(viewModel.comic)
        
    }
    
    func setupFaveButton(){
        
        comicImageView.addSubview(faveButton)
        faveButton.addTarget(self, action: #selector(faveButtonTapped(_:)), for: .touchUpInside)
        faveButton.leadingAnchor.constraint(equalTo: comicImageView.leadingAnchor, constant: 25).isActive = true
        faveButton.topAnchor.constraint(equalTo: comicImageView.topAnchor, constant: -5).isActive = true
        faveButton.widthAnchor.constraint(equalTo: comicImageView.widthAnchor, multiplier: 0.2).isActive = true
        faveButton.heightAnchor.constraint(equalTo: comicImageView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupComicNameLabel(){
        containerView.addSubview(comicNameLabel)
        comicNameLabel.text = viewModel.comic.title
        
        NSLayoutConstraint.activate([
            comicNameLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 5),
            comicNameLabel.topAnchor.constraint(equalTo: comicImageView.topAnchor, constant: 5),
            comicNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    func setupDescriptionScrollView(){
        
        containerView.addSubview(descScrollView)
        NSLayoutConstraint.activate([
            descScrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descScrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            descScrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
            ])
    }
    
    func setupComicDescriptionLabel(){
        
        comicDescriptionLabel.text = viewModel.comic.description.stripHTML()
        descScrollView.addSubview(comicDescriptionLabel)
        
        NSLayoutConstraint.activate([
            comicDescriptionLabel.topAnchor.constraint(equalTo: descScrollView.topAnchor, constant: 5),
            comicDescriptionLabel.trailingAnchor.constraint(equalTo: descScrollView.trailingAnchor),
            comicDescriptionLabel.widthAnchor.constraint(equalTo: descScrollView.widthAnchor),
            comicDescriptionLabel.leadingAnchor.constraint(equalTo: descScrollView.leadingAnchor),
            comicDescriptionLabel.bottomAnchor.constraint(equalTo: descScrollView.bottomAnchor)
            ])
    }
    
    func setupComicPriceLabel(){
        containerView.addSubview(comicPriceLabel)
        comicPriceLabel.text = "Price: " + String(viewModel.comic.price)
        
        NSLayoutConstraint.activate([
            comicPriceLabel.topAnchor.constraint(equalTo: comicNameLabel.bottomAnchor, constant: 5),
            comicPriceLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 5)
            ])
        
    }
    
    func setupDetailsButton(){
        containerView.addSubview(comicDetailsButton)

        NSLayoutConstraint.activate([
            comicDetailsButton.bottomAnchor.constraint(equalTo: descScrollView.topAnchor, constant: -5),
            comicDetailsButton.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 5)
            ])
        
    }
    
    func setupPurchaseButton(){
        
        containerView.addSubview(comicPurchaseButton)
        
        NSLayoutConstraint.activate([
            comicPurchaseButton.bottomAnchor.constraint(equalTo: descScrollView.topAnchor, constant: -5),
            comicPurchaseButton.leadingAnchor.constraint(equalTo: comicDetailsButton.trailingAnchor, constant: 10)
            ])
    }
    
    func setupComicCreatorsLabel(){
        containerView.addSubview(comicCreatorsLabel)
        comicCreatorsLabel.text = "Creators: " + viewModel.comic.creators
        NSLayoutConstraint.activate([
            comicCreatorsLabel.topAnchor.constraint(equalTo: comicPriceLabel.bottomAnchor, constant: 5),
            comicCreatorsLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 5),
            comicCreatorsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            comicCreatorsLabel.bottomAnchor.constraint(equalTo: comicDetailsButton.topAnchor)
            ])
    }
    
    func setupCharacterCollection(){

        view.addSubview(characterCollectionView)
        NSLayoutConstraint.activate([
            characterCollectionView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            characterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

    }

    @objc func detailsButtonTapped(_ sender: Any) {
        for items in viewModel.comic.urls{
            if items.type.lowercased() == "detail"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func purchaseButtonTapped(_ sender: Any) {
        for items in viewModel.comic.urls{
            if items.type.lowercased() == "purchase"{
                guard let url = URL(string: items.url) else { return }
                print("Opening url \(items.url)")
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func updateCharacterCollection(){
        DispatchQueue.main.async{
            self.characterCollectionView.reloadData()
        }
    }
}

extension ComicDetailsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: view.frame.width * 0.5, height: view.frame.height)
        print(size)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let detailsVC = CharacterDetailsViewController(thisCharacter: aCharacter(with: viewModel.comicCharacters[indexPath.row]))
        self.navigationController?.pushViewController(detailsVC, animated: true)    }
}

extension ComicDetailsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.comicCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = characterCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath as IndexPath) as! CharacterCollectionViewCell
        
        let thisCharacter = viewModel.comicCharacters[indexPath.row]
        cell.configure(with: aCharacter(with: thisCharacter))
        return cell
    }
    
    
}

//extension ComicDetailsViewController: CharacterCollectionTableViewCellDelegate{
//    func pushToNavigationController(for character: aCharacter) {
//        
//        let detailsVC = CharacterDetailsViewController(thisCharacter: character)
//        self.navigationController?.pushViewController(detailsVC, animated: true)
//    }
//    
//}
