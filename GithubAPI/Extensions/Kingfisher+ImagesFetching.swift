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
            if let url = URL(string: url) {
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
    
}
