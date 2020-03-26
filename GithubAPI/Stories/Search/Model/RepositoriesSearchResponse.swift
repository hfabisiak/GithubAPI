import Foundation

struct RepositoriesSearchResponse: Decodable {
    
    //MARK: - Internal stored properties
    
    let totalCount: Int
    let repos: [Repository]

    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case repos = "items"
    }
    
}
