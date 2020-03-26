import Foundation

typealias RepositoriesSearchProviderCompletion = ((Result<RepositoriesPage, Error>) -> Void)

protocol RepositoriesProviding {
    
    func search(_ query: String,
                for page: Int,
                with completion: @escaping RepositoriesSearchProviderCompletion)
    
}
