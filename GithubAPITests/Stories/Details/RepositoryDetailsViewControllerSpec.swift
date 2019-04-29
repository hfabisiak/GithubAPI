//
//  RepositoryDetailsViewControllerSpec.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

@testable import GithubAPI
import Quick
import Nimble
import SnapshotTesting

class RepositoryDetailsViewControllerSpec: QuickSpec {
    override func spec() {
        describe("class RepositoryDetailsViewController") {
            var sut: RepositoryDetailsViewController!
            var repository: Repository!
            
            beforeEach {
                repository = Repository(id: 2,
                                        fullName: "LoveDaisy/tetris_game",
                                        description: "It is really nice game Tetris, this text should not fit the screen, so we need to add three dots at the end of the label",
                                        language: "C++",
                                        forksCount: 2,
                                        watchers: 24,
                                        owner: RepositoryOwner(login: "Thor", avatarURL: "github_pic_2.jpg"))
                sut = RepositoryDetailsViewController(repository: repository)
                _ = sut.view
                record = true
            }
            
            afterEach {
                sut = nil
                repository = nil
                record = false
            }
            
            context("view did load") {
                describe("loaded view") {
                    it("should be of type RepositoryDetailsView") {
                        expect(sut.view).to(beAnInstanceOf(RepositoryDetailsView.self))
                        expect(sut.repositoryDetailsView).to(beAnInstanceOf(RepositoryDetailsView.self))
                    }
                }
                
                describe("navigation item") {
                    it("should never display large titles") {
                        expect(sut.navigationItem.largeTitleDisplayMode) == .never
                    }
                    
                    it("should have correct title") {
                        expect(sut.navigationItem.title) == repository.fullName
                    }
                }
            }
            
            describe("displaying list of repository details") {
                it("should have RepositoryDetailsCell registered") {
                    let cell = sut.repositoryDetailsView.detailsTableView.dequeueReusableCell(withIdentifier: RepositoryDetailsCell.reuseIdentifier) as? RepositoryDetailsCell
                    expect(cell).toNot(beNil())
                }
                
                it("should have cell properly configured") {
                    let cell = sut.repositoryDetailsView.detailsTableView.dataSource?.tableView(sut.repositoryDetailsView.detailsTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? RepositoryDetailsCell
                    expect(cell).notTo(beNil())
                    expect(cell?.titleLabel.text) == "Name:"
                    expect(cell?.detailsLabel.text) == repository.fullName
                }
                
                it("should have 2 sections") {
                    let numberOfSections = sut.repositoryDetailsView.detailsTableView.dataSource?.numberOfSections?(in: sut.repositoryDetailsView.detailsTableView)
                    expect(numberOfSections) == 2
                }
                
                describe("sections") {
                    describe("1st section") {
                        it("should have 6 rows") {
                            let numberOfRows = sut.repositoryDetailsView.detailsTableView.dataSource?.tableView(sut.repositoryDetailsView.detailsTableView, numberOfRowsInSection: 0)
                            expect(numberOfRows) == 6
                        }
                        
                        it("should have correct title") {
                            let title = sut.repositoryDetailsView.detailsTableView.dataSource?.tableView?(sut.repositoryDetailsView.detailsTableView, titleForHeaderInSection: 0)
                            expect(title) == "Details"
                        }
                    }
                    
                    describe("2nd section") {
                        it("should have 1 row") {
                            let numberOfRows = sut.repositoryDetailsView.detailsTableView.dataSource?.tableView(sut.repositoryDetailsView.detailsTableView, numberOfRowsInSection: 1)
                            expect(numberOfRows) == 1
                        }
                        
                        it("should have correct title") {
                            let title = sut.repositoryDetailsView.detailsTableView.dataSource?.tableView?(sut.repositoryDetailsView.detailsTableView, titleForHeaderInSection: 1)
                            expect(title) == "Owner"
                        }
                    }
                }
                
                it("should have correct row height") {
                    expect(sut.repositoryDetailsView.detailsTableView.estimatedRowHeight) == 50.0
                    expect(sut.repositoryDetailsView.detailsTableView.rowHeight) == UITableView.automaticDimension
                }
                
            }
            
            describe("required initializer") {
                it("should return nil") {
                    expect(RepositoryDetailsViewController(coder: NSCoder())).to(beNil())
                }
            }
            
            it("should match snapshot on iPhone SE") {
                assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
            }
            
            it("should match snapshot on iPhone 8") {
                assertSnapshot(matching: sut, as: .image(on: .iPhone8))
            }
            
            it("should match snapshot on iPhone 8 Plus") {
                assertSnapshot(matching: sut, as: .image(on: .iPhone8Plus))
            }
            
            it("should match snapshot on iPhone X") {
                assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
            }
            
            it("should match snapshot on iPhone Xs Max") {
                assertSnapshot(matching: sut, as: .image(on: .iPhoneXsMax))
            }
            
        }
    }
}
