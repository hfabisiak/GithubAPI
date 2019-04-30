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
         repositoryPresenter: RepositoryPresenting = RepositoryPresenter(),
         searchReducer: SearchReducing = SearchReducer()) {
        self.searchControllerFactory = searchControllerFactory
        self.repositoriesProvider = repositoriesProvider
        self.repositoryPresenter = repositoryPresenter
        self.searchReducer = searchReducer
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
    private let searchReducer: SearchReducing
    private var state = SearchState() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.resultsTableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        searchView.resultsTableView.dataSource = self
        searchView.resultsTableView.delegate = self
    }
    
    private func performEvent(_ event: SearchServiceEvent) {
        searchReducer.reduce(oldState: state, event: event) { [weak self] state in
            self?.state = state
        }
    }
    
    @objc private func reloadResults(_ searchBar: UISearchBar) {
        if let query = searchBar.text, !query.isEmpty {
            performEvent(.queryChanged(query))
        }
    }
    
    required init?(coder _: NSCoder) { return nil }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reloadResults), object: searchBar)
        perform(#selector(reloadResults), with: searchBar, afterDelay: 0.5)
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoryDetailsViewController = RepositoryDetailsViewController(repository: state.items[indexPath.row])
        pushController?(repositoryDetailsViewController, true)
    }
    
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryCell = tableView.dequeueReusableCell(for: indexPath)
        repositoryPresenter.present(model: state.items[indexPath.row], for: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == state.items.count - 1 {
            performEvent(.loadNextPage)
        }
    }

}
