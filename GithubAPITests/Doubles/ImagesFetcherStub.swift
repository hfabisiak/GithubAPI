@testable import GithubAPI
import UIKit

final class ImagesFetcherStub: ImagesFetching {
    
    func fetchImage(with url: String, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        guard let image = UIImage(named: url, in: Bundle.testBundle, compatibleWith: nil) else { return }
        completion(.success(image))
    }
    
}
