//
//  RepoSearchError.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

enum RepoSearchError: Error {
    case searchError(SearchErrorsResponse?)
}

extension RepoSearchError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .searchError(error):
            return error?.errors.first?.message ?? error?.message
        }
    }
}
