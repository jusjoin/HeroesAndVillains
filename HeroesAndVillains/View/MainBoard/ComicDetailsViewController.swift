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
    
    lazy var detailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterCollectionTableViewCell.self, forCellReuseIdentifier: "CharacterCollectionTableViewCell")
        tableView.tableFooterView = .init(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var viewModel = ViewModel()
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

        SetupContainerView()
        SetupDescriptionScrollView()
        SetupComicImageView()
        SetupComicDescriptionLabel()
        SetupFaveButton()
        SetupComicNameLabel()
        SetupComicPriceLabel()
        SetupDetailsButton()
        SetupPurchaseButton()
        SetupComicCreatorsLabel()
        SetupDetailsTableView()
        SetupCharacterCollection()
        
        comicDetailsButton.addTarget(self, action: #selector(detailsButtonTapped(_:)), for: .touchUpInside)
        comicPurchaseButton.addTarget(self, action: #selector(purchaseButtonTapped(_:)), for: .touchUpInside)
        faveButton.addTarget(self, action: #selector(faveButtonTapped(_:)), for: .touchUpInside)
    }
    
    func SetupContainerView(){
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            ])
        
    }
    
    func SetupComicImageView(){
        
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
    
    func SetupFaveButton(){
        
        comicImageView.addSubview(faveButton)
        faveButton.addTarget(self, action: #selector(faveButtonTapped(_:)), for: .touchUpInside)
        faveButton.leadingAnchor.constraint(equalTo: comicImageView.leadingAnchor, constant: 25).isActive = true
        faveButton.topAnchor.constraint(equalTo: comicImageView.topAnchor, constant: -5).isActive = true
        faveButton.widthAnchor.constraint(equalTo: comicImageView.widthAnchor, multiplier: 0.2).isActive = true
        faveButton.heightAnchor.constraint(equalTo: comicImageView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func SetupComicNameLabel(){
        containerView.addSubview(comicNameLabel)
        comicNameLabel.text = viewModel.comic.title
        
        NSLayoutConstraint.activate([
            comicNameLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 5),
            comicNameLabel.topAnchor.constraint(equalTo: comicImageView.topAnchor, constant: 5),
            comicNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    func SetupDescriptionScrollView(){
        
        containerView.addSubview(descScrollView)
        NSLayoutConstraint.activate([
            descScrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descScrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            descScrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
            ])
    }
    
    func SetupComicDescriptionLabel(){
        
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
    
    func SetupComicPriceLabel(){
        containerView.addSubview(comicPriceLabel)
        comicPriceLabel.text = "Price: " + String(viewModel.comic.price)
        
        NSLayoutConstraint.activate([
            comicPriceLabel.topAnchor.constraint(equalTo: comicNameLabel.bottomAnchor, constant: 5),
            comicPriceLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 5)
            ])
        
    }
    
    func SetupDetailsButton(){
        containerView.addSubview(comicDetailsButton)

        NSLayoutConstraint.activate([
            comicDetailsButton.bottomAnchor.constraint(equalTo: descScrollView.topAnchor, constant: -5),
            comicDetailsButton.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 5)
            ])
        
    }
    
    func SetupPurchaseButton(){
        
        containerView.addSubview(comicPurchaseButton)
        
        NSLayoutConstraint.activate([
            comicPurchaseButton.bottomAnchor.constraint(equalTo: descScrollView.topAnchor, constant: -5),
            comicPurchaseButton.leadingAnchor.constraint(equalTo: comicDetailsButton.trailingAnchor, constant: 10)
            ])
    }
    
    func SetupComicCreatorsLabel(){
        containerView.addSubview(comicCreatorsLabel)
        comicCreatorsLabel.text = "Creators: " + viewModel.comic.creators
        NSLayoutConstraint.activate([
            comicCreatorsLabel.topAnchor.constraint(equalTo: comicPriceLabel.bottomAnchor, constant: 5),
            comicCreatorsLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 5),
            comicCreatorsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            comicCreatorsLabel.bottomAnchor.constraint(equalTo: comicDetailsButton.topAnchor)
            ])
    }
    
    func SetupDetailsTableView(){
        
        view.addSubview(detailsTableView)
        NSLayoutConstraint.activate([
            detailsTableView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            detailsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            detailsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    func SetupCharacterCollection(){

        detailsTableView.register(CharacterCollectionTableViewCell.self, forCellReuseIdentifier: "CharacterCollectionTableViewCell")

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
}

//MARK: Table view

extension ComicDetailsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let size = tableView.bounds.height
        print(size)
        return size
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {return "\(viewModel.comic.title) Characters"}
        
        return "Section"
    }
}

extension ComicDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCollectionTableViewCell", for: indexPath) as! CharacterCollectionTableViewCell
        cell.viewModel = self.viewModel
        cell.vcIdentifier = identifier
        cell.delegate = self
        cell.setupCharacterCollection()
        
        return cell
    }
    
    
}

extension ComicDetailsViewController: CharacterCollectionTableViewCellDelegate{
    func pushToNavigationController(for character: aCharacter) {
        
        let detailsVC = CharacterDetailsViewController()
        viewModel.character = character
        //detailsVC.viewModel = viewModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
