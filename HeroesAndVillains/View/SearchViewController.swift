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
        searchController.searchBar.scopeButtonTitles = ["Characters", "Comics"]
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupSearch(){
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(UINib(nibName: CharacterTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: CharacterTableCell.identifier)
        searchTableView.register(UINib(nibName: ComicTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ComicTableCell.identifier)
        searchTableView.tableFooterView = UIView(frame: .zero)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSearch), name: Notification.Name.CharacterNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSearch), name: Notification.Name.CVComicsNotification, object: nil)
    }
    
    @objc func updateSearch(){
        
        DispatchQueue.main.async{
            self.searchTableView.reloadData()
        }
    }
    
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch searchController.searchBar.selectedScopeButtonIndex{
        case 0:
            let detailsVC = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
            detailsVC.viewModel = viewModel
            detailsVC.viewModel.character = aCharacter(with: viewModel.characters[indexPath.row])
            self.navigationController?.pushViewController(detailsVC, animated: true)
        case 1:
            let detailsVC = storyboard?.instantiateViewController(withIdentifier: "ComicDetailsViewController") as! ComicDetailsViewController
            detailsVC.viewModel = viewModel
            detailsVC.viewModel.comic = Comic(with: viewModel.cvComics[indexPath.row])
            self.navigationController?.pushViewController(detailsVC, animated: true)
        default:
            let detailsVC = UIViewController()
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension SearchViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchController.searchBar.selectedScopeButtonIndex{
        case 0:
            return viewModel.characters.count
        case 1:
            return viewModel.cvComics.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("Search scope \(searchController.searchBar.selectedScopeButtonIndex)")
        switch searchController.searchBar.selectedScopeButtonIndex{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableCell.identifier, for: indexPath) as! CharacterTableCell
            
            let thisCharacter = viewModel.characters[indexPath.row]
            cell.configure(with: aCharacter(with: thisCharacter))
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableCell.identifier, for: indexPath) as! ComicTableCell
            
            let thisComic = viewModel.cvComics[indexPath.row]
            cell.configure(with: Comic(with: thisComic))
            
            return cell
            
        default:
            print("How did we get here? 100")
            let someCell = UITableViewCell()
            return someCell
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let search = searchBar.text?.addingPercentEncoding(withAllowedCharacters: CharacterSet.customAllowedURLCharacters()) else {
            return
        }
        
        switch searchController.searchBar.selectedScopeButtonIndex{
        case 0:
            if search.trimmingCharacters(in: .whitespaces).isEmpty{
                
                viewModel.getCharacters()
            }else{
                
                viewModel.getCharactersByName(name: search)
            }
        case 1:
            if search.trimmingCharacters(in: .whitespaces).isEmpty{
                
                viewModel.getCVComicsWithName(name: search)
            }else{
                
                viewModel.getCVComicsWithName(name: search)
            }
            
        default:
            print("How did we get here? 010")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch searchController.searchBar.selectedScopeButtonIndex{
        case 0:
            print("Character search selected")
        case 1:
            print("Comic search selected")
        default:
            print("How did we get here? 001")
        }
    }
    
}
