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
        searchController.dimsBackgroundDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.placeholder = "Search repository by name"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        setupTableView()
    }
    
    private func setupTableView() {
        searchView.resultsTableView.register(cell: RepositoryCell.self)
        searchView.resultsTableView.dataSource = self
    }
    
    // MARK: - Private
    
    private let searchControllerFactory: SearchRepositoryControllerFactory
    private let repositoriesProvider: RepositoriesProviding
    private let imagesFetcher: ImagesFetching
    
    required init?(coder _: NSCoder) { return nil }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        repositoriesProvider.search(searchController.searchBar.text ?? "") { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.searchView.resultsTableView.reloadData()
                }
            default: break
            }
        }
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
            default: break
            }
        }
        cell.topLabel.text = model.fullName
        cell.bottomLabel.text = model.description ?? "-"
        return cell
    }

}
