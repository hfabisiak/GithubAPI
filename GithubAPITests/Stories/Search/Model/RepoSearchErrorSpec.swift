//
//  RepoSearchErrorSpec.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

@testable import GithubAPI
import Foundation
import Quick
import Nimble

class RepoSearchErrorSpec: QuickSpec {
    
    override func spec() {
        describe("RepoSearchError") {
            var searchErrorsResponseStub: SearchErrorsResponse!
            var sut: RepoSearchError!
            
            beforeEach {
                searchErrorsResponseStub = SearchErrorsResponse(message: "This is error message",
                                                                errors: [])
                sut = RepoSearchError.searchError(searchErrorsResponseStub)
            }
            
            afterEach {
                sut = nil
                searchErrorsResponseStub = nil
            }
            
            it("should have correct message") {
                expect(sut.errorDescription) == "This is error message"
            }
        }
    }

}
