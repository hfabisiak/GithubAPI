import Foundation

struct SearchErrorsResponse: Decodable {
    
    //MARK: - Internal stored properties
    
    let message: String
    let errors: [SearchError]
    
    struct SearchError: Decodable {
        let message: String?
        let resource: String
        let field: String
        let code: String
    }
}
