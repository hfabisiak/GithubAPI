//
//  RepositoryDetailsPresenter.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 30/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

class RepositoryDetailsPresenter: RepositoryDetailsPresenting {
    
    func present(model: Repository, in cell: RepositoryDetailsCell, for indexPath: IndexPath) {
        let detailSpecific = RepositoryDetailsSpecifics.allCases[indexPath.row]
        let repositoryDetail = model.detail(for: detailSpecific) ?? "-"
        cell.titleLabel.text = [detailSpecific.rawValue, ":"].joined()
        cell.detailsLabel.text = repositoryDetail
    }

}

private extension Repository {
    
    func detail(for detailSpecific: RepositoryDetailsSpecifics) -> String? {
        switch detailSpecific {
        case .name:
            return fullName
        case .description:
            return description
        case .language:
            return language
        case .forks:
            return String(forksCount)
        case .watchers:
            return String(watchersCount)
        case .stargazers:
            return String(stargazersCount)
        case .openIssues:
            return String(openIssuesCount)
        case .owner:
            return owner.login
        case .license:
            return license?.name
        }
    }
    
}
