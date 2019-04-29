//
//  RepositoriesSearchResponse.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

struct RepositoriesSearchResponse: Decodable {
    let totalCount: Int
    let repos: [Repository]

    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case repos = "items"
    }
    
}
