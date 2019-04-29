//
//  Bundle+TestBundle.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

extension Bundle {
    
    static var testBundle: Bundle {
        let optionalTestBundle = allBundles.first { $0.bundlePath.hasSuffix(".xctest") }
        guard let testBundle = optionalTestBundle else {
            fatalError("Could not find test bundle")
        }
        
        return testBundle
    }
    
}
