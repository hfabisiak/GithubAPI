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
    
    init(searchControllerFactory: @escaping SearchRepositoryControllerFactory = { UISearchController(searchResultsController: nil) },
         repositoriesProvider: RepositoriesProviding = RepositoriesProvider(),
         repositoryPresenter: RepositoryPresenting = RepositoryPresenter()) {
        self.searchControllerFactory = searchControllerFactory
        self.repositoriesProvider = repositoriesProvider
        self.repositoryPresenter = repositoryPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    var searchView: SearchView {
        return view as! SearchView
    }
    
    // MARK: - Helpers
    
    lazy var pushController: ((UIViewController, Bool) -> Void)? = navigationController?.pushViewController(_:animated:)
    
    // MARK: - Child controllers
    
    lazy var searchController: UISearchController = searchControllerFactory()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true

        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Repositories"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search repository by name"
        searchController.searchBar.delegate = self
    
        setupTableView()
    }
    
    // MARK: - Private
    
    private let searchControllerFactory: SearchRepositoryControllerFactory
    private let repositoriesProvider: RepositoriesProviding
    private let repositoryPresenter: RepositoryPresenting
    
    private func setupTableView() {
        searchView.resultsTableView.dataSource = self
        searchView.resultsTableView.delegate = self
    }
    
    @objc private func reloadResults(for query: String) {
        repositoriesProvider.search(query) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.searchView.resultsTableView.reloadData()
                }
            default: break
            }
        }
    }
    
    required init?(coder _: NSCoder) { return nil }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadResults(for: searchText)
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoryDetailsViewController = RepositoryDetailsViewController(repository: repositoriesProvider.repositories[indexPath.row])
        pushController?(repositoryDetailsViewController, true)
    }
    
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesProvider.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryCell = tableView.dequeueReusableCell(for: indexPath)
        repositoryPresenter.present(model: repositoriesProvider.repositories[indexPath.row], for: cell)
        return cell
    }

}
