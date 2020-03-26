@testable import GithubAPI
import Quick
import Nimble

final class RepositoryDetailsViewSpec: QuickSpec {
    
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
