//
//  SearchErrorsResponse.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

struct SearchErrorsResponse: Decodable {
    let message: String
    let errors: [SearchError]
    
    struct SearchError: Decodable {
        let message: String?
        let resource: String
        let field: String
        let code: String
    }
}
