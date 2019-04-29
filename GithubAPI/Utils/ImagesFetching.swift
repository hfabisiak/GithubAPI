//
//  ImagesFetching.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import UIKit

typealias ImagesFetchingCompletion = ((Result<UIImage, Error>) -> Void)

protocol ImagesFetching {
    func fetchImage(with url: String, completion: @escaping ImagesFetchingCompletion)
}

