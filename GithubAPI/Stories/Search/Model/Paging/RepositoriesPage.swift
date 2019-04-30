//
//  RepositoriesPage.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 30/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

struct RepositoriesPage {
    let results: [Repository]
    let pageIndex: Int
    let nextPageIndex: Int?
    let numberOfAllRepositories: Int
}
