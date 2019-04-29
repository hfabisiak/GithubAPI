//
//  RepositoriesProviderSpec.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

@testable import GithubAPI
import Quick
import Nimble
import OHHTTPStubs

class RepositoriesProviderSpec: QuickSpec {
    
    override func spec() {
        describe("RepositoriesProvider") {
            var sut: RepositoriesProvider!
            var jsonDecoderStub: JSONDecoder!
            var urlSessionStub: URLSession!
            
            beforeEach {
                jsonDecoderStub = JSONDecoder()
                urlSessionStub = URLSession.shared
                sut = RepositoriesProvider(decoder: jsonDecoderStub, session: urlSessionStub)
            }
            
            afterEach {
                sut = nil
                urlSessionStub = nil
                jsonDecoderStub = nil
                OHHTTPStubs.removeAllStubs()
            }
            
            it("conforms to RepositoriesProviding protocol") {
                expect(sut).to(beAKindOf(RepositoriesProviding.self))
            }
            
            describe("search request") {
                it("should have correct host name and path") {
                    stub(condition: isHost("api.github.com") && isPath("/search/repositories")) { dada in
                        let stubPath = OHPathForFile("repositories_search.json", type(of: self))
                        return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
                    }
                    
                    waitUntil(timeout: 1.0, action: { done in
                        sut.search("tetris", with: { result in
                            switch result {
                            case let .success(response) where response.count == 30:
                                done()
                            default:
                                break
                            }
                        })
                    })
                }
            }
        }
    }
    
}
