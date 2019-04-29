//
//  Kingfisher+ImagesFetching.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation
import Kingfisher

extension KingfisherManager: ImagesFetching {
    
    func fetchImage(with url: String, completion: @escaping ImagesFetchingCompletion) {
        func fetchImage(with url: String, completion: @escaping ImagesFetchingCompletion) {
            guard let url = URL(string: url) else { return }
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case let .success(response):
                    completion(.success(response.image))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
    
}
