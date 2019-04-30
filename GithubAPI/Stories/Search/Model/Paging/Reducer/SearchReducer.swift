//
//  SearchReducer.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 30/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

class SearchReducer: SearchReducing {
    
    init(repositoriesProvider: RepositoriesProviding = RepositoriesProvider()) {
        self.repositoriesProvider = repositoriesProvider
    }

    func reduce(oldState: SearchState, event: SearchServiceEvent, with completion: @escaping (SearchState) -> Void) {
        var newState = oldState
        switch event {
        case .loadNextPage:
            newState.shouldLoadNext = true
        case let .queryChanged(query):
            newState.nextPage = 1
            newState.numberOfAllRepositories = 30
            newState.query = query
            newState.shouldLoadNext = true
        }
        repositoriesProvider.search(newState.query, for: newState.loadPageIndex) { result in
            switch result {
            case let .success(page):
                
                switch event {
                case .queryChanged:
                    newState.items = page.results
                case .loadNextPage:
                    newState.items += page.results
                }
                
                newState.nextPage = page.nextPageIndex
                newState.numberOfAllRepositories = page.numberOfAllRepositories
                newState.shouldLoadNext = false
                completion(newState)
            case .failure:
                completion(newState)
            }
        }
    }
    
    // MARK: - Private
    
    private let repositoriesProvider: RepositoriesProviding
}
