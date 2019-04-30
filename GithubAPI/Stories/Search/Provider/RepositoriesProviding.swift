//
//  RepositoriesProviding.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

typealias RepositoriesSearchProviderCompletion = ((Result<RepositoriesPage, Error>) -> Void)

protocol RepositoriesProviding {
    func search(_ query: String,
                for page: Int,
                with completion: @escaping RepositoriesSearchProviderCompletion)
    
}
