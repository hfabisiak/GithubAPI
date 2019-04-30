//
//  RepositoryDetailsSpecifics.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 30/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

enum RepositoryDetailsSpecifics: String, CaseIterable {
    case name = "Full name"
    case owner = "Owner"
    case description = "Description"
    case language = "Language"
    case forks = "Forks"
    case watchers = "Watchers"
    case stargazers = "Stargazers"
    case openIssues = "Open issues"
    case license = "License"
}
