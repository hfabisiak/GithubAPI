//
//  RepositoryDetailsViewSpec.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

@testable import GithubAPI
import Quick
import Nimble

class RepositoryDetailsViewSpec: QuickSpec {
    
    override func spec() {
        describe("RepositoryDetailsView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(RepositoryDetailsView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }
    
}
