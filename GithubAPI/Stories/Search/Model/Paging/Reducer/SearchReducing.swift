//
//  SearchReducing.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 30/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

protocol SearchReducing {
    
    func reduce(oldState: SearchState,
                event: SearchServiceEvent,
                with completion: @escaping (SearchState) -> Void)
    
}
