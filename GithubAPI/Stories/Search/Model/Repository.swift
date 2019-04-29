//
//  Repository.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    let id: Int64
    let fullName: String
    let description: String?
    let language: String?
    let forksCount: Int
    let watchers: Int
    let owner: RepositoryOwner
    
    private enum CodingKeys: String, CodingKey {
        case id, language, description, watchers, owner
        case forksCount = "forks_count"
        case fullName = "full_name"
    }
}
