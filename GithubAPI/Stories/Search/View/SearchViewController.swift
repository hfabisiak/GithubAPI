//
//  SearchViewController.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    typealias SearchRepositoryControllerFactory = () -> UISearchController
    
    init(searchControllerFactory: @escaping SearchRepositoryControllerFactory = { UISearchController(searchResultsController: nil) }) {
        self.searchControllerFactory = searchControllerFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    var searchView: SearchView {
        return view as! SearchView
    }
    
    // MARK: - Child controllers
    
    lazy var searchController: UISearchController = searchControllerFactory()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Repositories"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.placeholder = "Search repository by name"
        navigationItem.searchController = searchController
    }
    
    // MARK: - Private
    
    private let searchControllerFactory: SearchRepositoryControllerFactory
    
    required init?(coder _: NSCoder) { return nil }
}
