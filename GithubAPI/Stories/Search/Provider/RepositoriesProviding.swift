//
//  RepositoriesProviding.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

typealias RepositoriesSearchProviderCompletion = ((Result<RepositoriesSearchResponse, Error>) -> Void)

protocol RepositoriesProviding {
    
    func search(_ query: String,
                with completion: @escaping RepositoriesSearchProviderCompletion)
    
}