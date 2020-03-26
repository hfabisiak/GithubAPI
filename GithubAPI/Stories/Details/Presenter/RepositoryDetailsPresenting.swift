import Foundation

protocol RepositoryDetailsPresenting {
    
    func present(model: Repository,
                 in cell: RepositoryDetailsCell,
                 for indexPath: IndexPath)
    
}
