import Foundation

final class SearchReducer: SearchReducing {
    
    //MARK: - Private stored properties
    
    private let repositoriesProvider: RepositoriesProviding
    
    //MARK: - Internal methods
    
    init(repositoriesProvider: RepositoriesProviding = RepositoriesProvider()) {
        self.repositoriesProvider = repositoriesProvider
    }

    func reduce(oldState: SearchState, event: SearchServiceEvent, with completion: @escaping (SearchState) -> Void) {
        var newState = oldState
        switch event {
        case .loadNextPage:
            newState.shouldLoadNext = true
        case let .queryChanged(query):
            newState.nextPage = 1
            newState.numberOfAllRepositories = 30
            newState.query = query
            newState.shouldLoadNext = true
        }
        repositoriesProvider.search(newState.query, for: newState.loadPageIndex) { result in
            switch result {
            case let .success(page):
                switch event {
                case .queryChanged:
                    newState.items = page.results
                case .loadNextPage:
                    newState.items += page.results
                }
                newState.nextPage = page.nextPageIndex
                newState.numberOfAllRepositories = page.numberOfAllRepositories
                newState.shouldLoadNext = false
                completion(newState)
            case .failure:
                completion(newState)
            }
        }
    }
     
}
