//
//  Repository+Init.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 30/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

@testable import GithubAPI
import Foundation

extension Repository {
    init(id: Int64,
         fullName: String,
         description: String?,
         language: String,
         forksCount: Int,
         watchersCount: Int,
         owner: RepositoryOwner) {
        self.init(id: id, fullName: fullName, description: description, language: language, forksCount: forksCount, watchersCount: watchersCount, stargazersCount: 0, openIssuesCount: 0, owner: owner, license: nil)
    }
}
