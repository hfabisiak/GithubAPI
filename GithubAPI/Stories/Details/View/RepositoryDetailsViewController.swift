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
    
    init(repository: Repository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = RepositoryDetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = repository.fullName
        navigationItem.largeTitleDisplayMode = .never
        setupTableView()
    }
    
    // MARK: - Private
    
    private let repository: Repository
    
    private func setupTableView() {
        repositoryDetailsView.detailsTableView.dataSource = self
    }
    
    required init?(coder _: NSCoder) { return nil }
}

extension RepositoryDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 6 : 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryDetailsCell = tableView.dequeueReusableCell(for: indexPath)
        cell.titleLabel.text = "Name:"
        cell.detailsLabel.text = repository.fullName
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Details" : "Owner"
    }
    
}


