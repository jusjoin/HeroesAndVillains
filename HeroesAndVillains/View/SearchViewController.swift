//
//  SearchViewController.swift
//  HeroesAndVillains
//
//  Created by Admin on 6/3/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    
    let viewModel = ViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createSearch()
        setupNavigation()
        setupSearch()
        
        
    }
    
    func setupNavigation(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = Constants.Keys.searchTitle.rawValue
    }
    
    func createSearch(){
    searchController.searchBar.placeholder = "Search Heroes and Villains"
    searchController.dimsBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.delegate = self
    definesPresentationContext = true
    
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupSearch(){
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(UINib(nibName: CharacterTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: CharacterTableCell.identifier)
        searchTableView.tableFooterView = UIView(frame: .zero)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSearch), name: Notification.Name.CharacterNotification, object: nil)
    }
    
    @objc func updateSearch(){
        print("Table reloaded")
        DispatchQueue.main.async{
            self.searchTableView.reloadData()
        }
    }


}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
        detailsVC.viewModel.character = aCharacter(with: viewModel.characters[indexPath.row])
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension SearchViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableCell.identifier, for: indexPath) as! CharacterTableCell
        
        let thisCharacter = viewModel.characters[indexPath.row]
        cell.configure(with: aCharacter(with: thisCharacter))
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        var allowedChars = CharacterSet(charactersIn: "-._~/? ")
//        allowedChars.formUnion(CharacterSet.alphanumerics)
        guard let search = searchBar.text?.addingPercentEncoding(withAllowedCharacters: CharacterSet.customAllowedURLCharacters()) else {
            return
        }
        
        if search.trimmingCharacters(in: .whitespaces).isEmpty{
            
            viewModel.getCharacters()
        }else{
            
            viewModel.getCharactersByName(name: search)
        }
    }

}
