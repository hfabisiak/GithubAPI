//
//  RepositoryPresenter.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 30/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryPresenter: RepositoryPresenting {
    
    init(imagesFetcher: ImagesFetching = KingfisherManager.shared) {
        self.imagesFetcher = imagesFetcher
    }
    
    func present(model: Repository, for cell: RepositoryCell) {
        imagesFetcher.fetchImage(with: model.owner.avatarURL) { [cell] result in
            switch result {
            case let .success(image):
                cell.avatarImageView.image = image
            case .failure:
                break
            }
        }
        cell.topLabel.text = model.fullName
        cell.bottomLabel.text = model.description ?? "-"
    }
    
    // MARK: - Private
    
    private let imagesFetcher: ImagesFetching
}
