import Foundation

enum RepoSearchError: Error {
    case searchError(SearchErrorsResponse?)
}

extension RepoSearchError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case let .searchError(error):
            return error?.errors.first?.message ?? error?.message
        }
    }
    
}
