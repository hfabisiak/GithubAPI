import UIKit
import Kingfisher

final class RepositoryPresenter: RepositoryPresenting {
    
    //MARK: - Private stored properties
    
    private let imagesFetcher: ImagesFetching

    //MARK: - Internal methods
    
    init(imagesFetcher: ImagesFetching = KingfisherManager.shared) {
        self.imagesFetcher = imagesFetcher
    }
    
    func present(model: Repository, for cell: RepositoryCell) {
        imagesFetcher.fetchImage(with: model.owner.avatarURL) { [cell] result in
            switch result {
            case let .success(image):
                cell.avatarImageView.image = image
            case .failure:
                break
            }
        }
        cell.topLabel.text = model.fullName
        cell.bottomLabel.text = model.description ?? "-"
    }

}
