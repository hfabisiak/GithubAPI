@testable import GithubAPI
import Foundation
import Quick
import Nimble

final class SearchViewSpec: QuickSpec {
    
    override func spec() {
        describe("SearchView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(SearchView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }
    
}
