//
//  SearchState.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 30/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

struct SearchState {
    var items: [Repository]
    var nextPage: Int?
    var numberOfAllRepositories: Int
    var shouldLoadNext: Bool
    var query: String
    
    init() {
        query = ""
        items = []
        nextPage = 1
        numberOfAllRepositories = 30
        shouldLoadNext = true
    }
}

extension SearchState {
    
    var loadPageIndex: Int {
        if let nextPage = nextPage, shouldLoadNext && numberOfAllRepositories > items.count {
            return nextPage
        }
        return 1
    }
}
