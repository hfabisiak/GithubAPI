//
//  SearchViewController.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    
    typealias SearchRepositoryControllerFactory = () -> UISearchController
    
    init(searchControllerFactory: @escaping SearchRepositoryControllerFactory = { UISearchController(searchResultsController: nil) },
         repositoriesProvider: RepositoriesProviding = RepositoriesProvider(),
         imagesFetcher: ImagesFetching = KingfisherManager.shared) {
        self.searchControllerFactory = searchControllerFactory
        self.repositoriesProvider = repositoriesProvider
        self.imagesFetcher = imagesFetcher
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
        searchController.searchResultsUpdater = self
    
        setupTableView()
    }
    
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
    
    // MARK: - Private
    
    private let searchControllerFactory: SearchRepositoryControllerFactory
    private let repositoriesProvider: RepositoriesProviding
    private let imagesFetcher: ImagesFetching
    
    required init?(coder _: NSCoder) { return nil }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        reloadResults(for: query)
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoryDetailsViewController = RepositoryDetailsViewController(repository: repositoriesProvider.repositories[indexPath.row])
        pushController?(repositoryDetailsViewController, true)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesProvider.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryCell = tableView.dequeueReusableCell(for: indexPath)
        let model = repositoriesProvider.repositories[indexPath.row]
        imagesFetcher.fetchImage(with: model.owner.avatarURL) { [cell] result in
            switch result {
            case let .success(image):
                cell.avatarImageView.image = image
            case .failure(_):
                break
            }
        }
        cell.topLabel.text = model.fullName
        cell.bottomLabel.text = model.description ?? "-"
        return cell
    }

}
