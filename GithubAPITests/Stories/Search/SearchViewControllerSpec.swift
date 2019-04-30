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
            var repositoriesProviderStub: RepositoriesProviding!
            var imagesFetcherStub: ImagesFetching!
            var repositoryPresenterStub: RepositoryPresenting!
            
            beforeEach {
                repositoriesProviderStub = RepositoriesProviderStub()
                imagesFetcherStub = ImagesFetcherStub()
                repositoryPresenterStub = RepositoryPresenter(imagesFetcher: imagesFetcherStub)
                sut = SearchViewController(repositoriesProvider: repositoriesProviderStub,
                                           repositoryPresenter: repositoryPresenterStub)
                navigationController = UINavigationController(rootViewController: sut)
                _ = sut.view
            }
            
            afterEach {
                navigationController = nil
                sut = nil
                repositoryPresenterStub = nil
                imagesFetcherStub = nil
                repositoriesProviderStub = nil
            }
            
            it("should have definesPresentationContext set to yes") {
                expect(sut.definesPresentationContext) == true
            }
            
            describe("loaded view") {
                it("should be of type SearchView") {
                    expect(sut.view).to(beAKindOf(SearchView.self))
                }
            }
            
            describe("navigation item") {
                it("should always display large title") {
                    expect(sut.navigationItem.largeTitleDisplayMode) == .always
                }
                
                it("should have correct title") {
                    expect(sut.navigationItem.title) == "Repositories"
                }
                
                it("should not hide search bar when scrolling") {
                    expect(sut.navigationItem.hidesSearchBarWhenScrolling) == false
                }
                
                describe("searchController") {
                    it("should not be nil") {
                        expect(sut.navigationItem.searchController).toNot(beNil())
                    }
                    
                    it("should have correct placeholder") {
                        expect(sut.navigationItem.searchController?.searchBar.placeholder) == "Search repository by name"
                    }
                    
                    it("should not dim background") {
                        expect(sut.searchController.dimsBackgroundDuringPresentation) == false
                    }
                    
                    it("should not hide navigation bar during presentation") {
                        expect(sut.searchController.hidesNavigationBarDuringPresentation) == false
                    }
                }
            }
            
            context("when it is wrapped in UINavigationController") {
                it("should prefer large titles") {
                    expect(sut.navigationController?.navigationBar.prefersLargeTitles) == true
                }
            }
            
            describe("Repositories table view") {
                
                it("should have RepositoryCell registered") {
                    let cell = sut.searchView.resultsTableView.dequeueReusableCell(withIdentifier: RepositoryCell.reuseIdentifier) as? RepositoryCell
                    expect(cell).toNot(beNil())
                }
                
                it("should have number of cells matching number of provided repositories") {
                    let numberOfCells = sut.searchView.resultsTableView.dataSource?.tableView(sut.searchView.resultsTableView, numberOfRowsInSection: 0)
                    expect(numberOfCells) == repositoriesProviderStub.repositories.count
                }
                
                it("should have properly configured cell") {
                    let cell = sut.searchView.resultsTableView.dataSource?.tableView(sut.searchView.resultsTableView, cellForRowAt: IndexPath(row: 2, section: 0)) as? RepositoryCell
                    expect(cell?.avatarImageView.image?.pngData()) == UIImage(named: "github_pic_3.png", in: Bundle.testBundle, compatibleWith: nil)?.pngData()
                    expect(cell?.topLabel.text) == "dionyziz/canvas-tetris"
                    expect(cell?.bottomLabel.text) == "-"
                }
                
                it("should have correct row height") {
                    expect(sut.searchView.resultsTableView.rowHeight) == 75.0
                }
                
                it("should throw assertion if there is no such indexPath") {
                    expect{
                        _ = sut.searchView.resultsTableView.dataSource?.tableView(sut.searchView.resultsTableView, cellForRowAt: IndexPath(row: 10, section: 1))
                    }.to(throwAssertion())
                }
                
                it("should throw assertion when trying to dequeue cell for non existing indexPath") {
                    expect{
                        _ = sut.searchView.resultsTableView.dequeueReusableCell(for: IndexPath(row: 10, section: 1))
                        }.to(throwAssertion())
                }
                
                it("should show repository details after choosing one from the list") {
                    var invokedPushController: [(Bool, UIViewController)] = []
                    sut.pushController = { controller, animated in
                        invokedPushController.append((animated, controller))
                    }
                    sut.searchView.resultsTableView.delegate?.tableView?(sut.searchView.resultsTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                    expect(invokedPushController).to(haveCount(1))
                }
            }
            
            context("Searching for repositories") {
                
                it("should have results updating") {
                    expect(sut.searchController.searchBar.delegate).toNot(beNil())
                }
                
                it("should update results when typing") {
                    sut.searchController.searchBar.delegate?.searchBar?(sut.searchController.searchBar, textDidChange: "ios")
                    waitUntil(timeout: 1.0, action: { isDoneCompletion in
                        expect(repositoriesProviderStub.repositories.isEmpty).to(beTrue())
                        isDoneCompletion()
                    })
                }
                
//                it("should cancel all previous requests when typing") {
//                    var numberOfRequests = sut.
//                    sut.searchController.searchBar.text = "ios"
//
//                }
            }
            
            describe("required initializer") {
                it("should return nil") {
                    expect(SearchViewController(coder: NSCoder())).to(beNil())
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
