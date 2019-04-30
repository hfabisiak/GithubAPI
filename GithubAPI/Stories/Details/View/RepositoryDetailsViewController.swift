//
//  RepositoryDetailsViewController.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    
    var repositoryDetailsView: RepositoryDetailsView {
        return view as! RepositoryDetailsView
    }
    
    init(repository: Repository,
         repositoryDetailsPresenter: RepositoryDetailsPresenting = RepositoryDetailsPresenter()) {
        self.repository = repository
        self.repositoryDetailsPresenter = repositoryDetailsPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = RepositoryDetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Repository details"
        navigationItem.largeTitleDisplayMode = .never
        setupTableView()
    }
    
    // MARK: - Private
    
    private let repository: Repository
    private let repositoryDetailsPresenter: RepositoryDetailsPresenting
    
    private func setupTableView() {
        repositoryDetailsView.detailsTableView.dataSource = self
    }
    
    required init?(coder _: NSCoder) { return nil }
}

extension RepositoryDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RepositoryDetailsSpecifics.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryDetailsCell = tableView.dequeueReusableCell(for: indexPath)
        repositoryDetailsPresenter.present(model: repository, in: cell, for: indexPath)
        return cell
    }

}


