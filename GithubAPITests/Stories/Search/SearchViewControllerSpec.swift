//
//  SearchViewControllerSpec.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

@testable import GithubAPI
import Quick
import Nimble
import SnapshotTesting

class SearchViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("SearchViewController") {
            var sut: SearchViewController!
            var navigationController: UINavigationController!
            
            beforeEach {
                sut = SearchViewController()
                navigationController = UINavigationController(rootViewController: sut)
                _ = sut.view
                record = true
            }
            
            afterEach {
                sut = nil
                navigationController = nil
                record = false
            }
            
            describe("loaded view") {
                it("should be of type SearchView") {
                    expect(sut.view).to(beAKindOf(SearchView.self))
                    expect(sut.searchView).to(beAKindOf(SearchView.self))
                }
            }
            
            describe("navigation item") {
                it("should always display large title") {
                    expect(sut.navigationItem.largeTitleDisplayMode) == .always
                }
                
                it("should have correct title") {
                    expect(sut.navigationItem.title) == "Repositories"
                }
            }
            
            context("when it is wrapped in UINavigationController") {
                it("should prefer large titles") {
                    expect(sut.navigationController?.navigationBar.prefersLargeTitles) == true
                }
            }

            it("should match snapshot on iPhone SE") {
                assertSnapshot(matching: navigationController, as: .image(on: .iPhoneSe))
            }
            
            it("should match snapshot on iPhone 8") {
                assertSnapshot(matching: navigationController, as: .image(on: .iPhone8))
            }
            
            it("should match snapshot on iPhone 8 Plus") {
                assertSnapshot(matching: navigationController, as: .image(on: .iPhone8Plus))
            }
            
            it("should match snapshot on iPhone X") {
                assertSnapshot(matching: navigationController, as: .image(on: .iPhoneX))
            }
            
            it("should match snapshot on iPhone Xs Max") {
                assertSnapshot(matching: navigationController, as: .image(on: .iPhoneXsMax))
            }
            
            
        }
    }
    
    
}
