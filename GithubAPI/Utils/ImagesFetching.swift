import UIKit

typealias ImagesFetchingCompletion = ((Result<UIImage, Error>) -> Void)

protocol ImagesFetching {
    func fetchImage(with url: String,
                    completion: @escaping ImagesFetchingCompletion)
}

