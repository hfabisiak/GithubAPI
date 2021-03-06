@testable import GithubAPI
import Quick
import Nimble
import OHHTTPStubs

final class RepositoriesProviderSpec: QuickSpec {
    
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
            
            describe("search request when url is malformed") {
                it("should throw an assertion when url is malformed") {
                    sut = RepositoriesProvider(decoder: jsonDecoderStub, session: urlSessionStub, apiRoute: "this is wrong route")
                    expect{
                        sut.search("tetris", for: 1, with: { _ in })
                    }.to(throwAssertion())
                }
            }
            
            describe("search request") {
                it("should have correct host name and path") {
                    stub(condition: isHost("api.github.com") && isPath("/search/repositories")) { dada in
                        let stubPath = OHPathForFile("repositories_search.json", type(of: self))
                        return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
                    }
                    
                    waitUntil(timeout: 1.0, action: { isDoneCompletion in
                        sut.search("tetris", for: 1, with: { result in
                            switch result {
                            case let .success(page) where page.results.count == 30:
                                isDoneCompletion()
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
