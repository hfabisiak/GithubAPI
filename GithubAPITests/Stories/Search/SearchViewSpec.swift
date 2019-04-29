//
//  SearchViewSpec.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

@testable import GithubAPI
import Foundation
import Quick
import Nimble

class SearchViewSpec: QuickSpec {
    
    override func spec() {
        describe("SearchView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(SearchView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }
    
}
