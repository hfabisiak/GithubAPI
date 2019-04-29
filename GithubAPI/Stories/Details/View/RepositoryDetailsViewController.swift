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
    }
    
    // MARK: - Private
    
    private let repository: Repository
    
    required init?(coder _: NSCoder) { return nil }
}
