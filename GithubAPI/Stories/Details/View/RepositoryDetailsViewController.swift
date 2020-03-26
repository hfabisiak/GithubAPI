import UIKit

final class RepositoryDetailsViewController: UIViewController {
    
    //MARK: - Internal computed properties
    
    var repositoryDetailsView: RepositoryDetailsView { view as! RepositoryDetailsView }
    
    //MARK: - Private stored properties

    private let repository: Repository
    private let repositoryDetailsPresenter: RepositoryDetailsPresenting
    
    //MARK: - Internal methods
    
    init(repository: Repository,
         repositoryDetailsPresenter: RepositoryDetailsPresenting = RepositoryDetailsPresenter()) {
        self.repository = repository
        self.repositoryDetailsPresenter = repositoryDetailsPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) { nil }
        
    override func loadView() {
        view = RepositoryDetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    //MARK: - Private methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Repository details"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTableView() {
        repositoryDetailsView.detailsTableView.dataSource = self
    }
    
}

// MARK: - UITableViewDataSource

extension RepositoryDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { RepositoryDetailsSpecifics.allCases.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryDetailsCell = tableView.dequeueReusableCell(for: indexPath)
        repositoryDetailsPresenter.present(model: repository, in: cell, for: indexPath)
        return cell
    }

}


