//
//  RepositoryDetailsCellSpec.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

@testable import GithubAPI
import Quick
import Nimble
import SnapshotTesting

class RepositoryDetailsCellSpec: QuickSpec {
    
    override func spec() {
        describe("RepositoryDetailsCell") {
            var sut: RepositoryDetailsCell!
            
            beforeEach {
                sut = RepositoryDetailsCell()
                sut.titleLabel.text = "Repository name:"
                sut.detailsLabel.text = "IronMan/Tetris"
                record = true
            }
            
            afterEach {
                sut = nil
                record = false
            }
            
            it("should match snapshot") {
                assertSnapshot(matching: sut, as: .image(size: CGSize(width: 375.0, height: 50.0)))
            }
            
            describe("required initializer") {
                it("should return nil") {
                    expect(RepositoryDetailsCell(coder: NSCoder())).to(beNil())
                }
            }
            
        }
    }
    
    
}
