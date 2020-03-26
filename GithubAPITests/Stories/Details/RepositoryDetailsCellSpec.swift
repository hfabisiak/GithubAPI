@testable import GithubAPI
import Quick
import Nimble
import SnapshotTesting

final class RepositoryDetailsCellSpec: QuickSpec {
    
    override func spec() {
        describe("RepositoryDetailsCell") {
            var sut: RepositoryDetailsCell!
            
            beforeEach {
                sut = RepositoryDetailsCell()
                sut.titleLabel.text = "Repository name:"
                sut.detailsLabel.text = "IronMan/Tetris"
            }
            
            afterEach {
                sut = nil
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
