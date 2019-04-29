//
//  ImagesFetcherStub.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

@testable import GithubAPI
import UIKit

class ImagesFetcherStub: ImagesFetching {
    
    func fetchImage(with url: String, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        guard let image = UIImage(named: url, in: Bundle.testBundle, compatibleWith: nil) else { return }
        completion(.success(image))
    }
    
}
