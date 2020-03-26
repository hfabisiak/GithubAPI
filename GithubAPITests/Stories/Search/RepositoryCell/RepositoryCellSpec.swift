@testable import GithubAPI
import Quick
import Nimble
import SnapshotTesting

final class RepositoryCellSpec: QuickSpec {
    
    override func spec() {
        describe("RepositoryCell") {
            var sut: RepositoryCell!
            
            beforeEach {
                sut = RepositoryCell()
                sut.avatarImageView.image = UIImage(named: "github_pic_1.jpg", in: Bundle.testBundle, compatibleWith: nil)
                sut.topLabel.text = "I am Iron Man!"
                sut.bottomLabel.text = "This is Iron man and his repository. I have repulsors so I can eleminate my enemies"
            }
            
            afterEach {
                sut = nil
            }
            
            it("should have correct reuse identifier") {
                expect(RepositoryCell.reuseIdentifier) == "RepositoryCell"
            }
            
            it("should match snapshot") {
                assertSnapshot(matching: sut, as: .image(size: CGSize(width: 375.0, height: 75.0)))
            }
            
            describe("required initializer") {
                it("should return nil") {
                    expect(RepositoryCell(coder: NSCoder())).to(beNil())
                }
            }
            
        }
    }
    
    
}

