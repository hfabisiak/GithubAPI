//
//  SearchServiceEvent.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 30/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

enum SearchServiceEvent {
    case loadNextPage
    case queryChanged(String)
}
