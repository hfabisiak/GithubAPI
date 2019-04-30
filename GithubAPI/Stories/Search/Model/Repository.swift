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
    let watchersCount: Int
    let stargazersCount: Int
    let openIssuesCount: Int
    let owner: RepositoryOwner
    let license: License?
    
    private enum CodingKeys: String, CodingKey {
        case id, language, description, owner, license
        case watchersCount = "watchers_count"
        case openIssuesCount = "open_issues_count"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case fullName = "full_name"
    }
}
