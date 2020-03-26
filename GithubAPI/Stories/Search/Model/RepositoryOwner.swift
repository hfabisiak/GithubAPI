import Foundation

struct RepositoryOwner: Decodable {
    
    //MARK: - Internal stored properties
    
    let login: String
    let avatarURL: String
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
