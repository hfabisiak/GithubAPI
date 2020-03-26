import Foundation

struct SearchState {
    
    //MARK: - Internal stored properties
    
    var items = [Repository]()
    var nextPage: Int? = 1
    var numberOfAllRepositories = 30
    var shouldLoadNext = true
    var query = ""

}

extension SearchState {
    
    var loadPageIndex: Int {
        guard let nextPage = nextPage, shouldLoadNext && numberOfAllRepositories > items.count else { return 1 }
        return nextPage
    }
    
}
