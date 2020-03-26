import UIKit

final class SearchViewController: UIViewController {
    
    typealias SearchRepositoryControllerFactory = () -> UISearchController
    
    //MARK: - Internal computed properties
    
    var searchView: SearchView { view as! SearchView }
    
    //MARK: - Internal stored properties
    
    lazy var pushController: ((UIViewController, Bool) -> Void)? = navigationController?.pushViewController(_:animated:)
    lazy var searchController: UISearchController = searchControllerFactory()
    
    //MARK: - Private stored properties
    
    private let searchControllerFactory: SearchRepositoryControllerFactory
    private let repositoryPresenter: RepositoryPresenting
    private let searchReducer: SearchReducing
    private var state: SearchState {
        didSet {
            DispatchQueue.main.async {
                self.searchView.resultsTableView.reloadData()
            }
        }
    }
    
    //MARK: - Internal methods
    
    init(searchControllerFactory: @escaping SearchRepositoryControllerFactory = { UISearchController(searchResultsController: nil) },
         repositoryPresenter: RepositoryPresenting = RepositoryPresenter(),
         state: SearchState = SearchState(),
         searchReducer: SearchReducing = SearchReducer()) {
        self.searchControllerFactory = searchControllerFactory
        self.repositoryPresenter = repositoryPresenter
        self.searchReducer = searchReducer
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) { nil }
        
    override func loadView() {
        view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        setupNavigationBar()
        setupSearchController()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchView.resultsTableView.deselectSelectedRow()
    }
    
    //MARK: - Private methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Repositories"
//        navigationItem.largeTitleDisplayMode = .always
//        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search repository by name"
        searchController.searchBar.delegate = self
    }

    private func setupTableView() {
        searchView.resultsTableView.dataSource = self
        searchView.resultsTableView.delegate = self
    }
    
    private func performEvent(_ event: SearchServiceEvent) {
        searchReducer.reduce(oldState: state, event: event) { [weak self] state in
            self?.state = state
        }
    }
    
    @objc private func reloadResults(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        performEvent(.queryChanged(query))
    }
    
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reloadResults), object: searchBar)
        perform(#selector(reloadResults), with: searchBar, afterDelay: 0.5)
    }
    
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoryDetailsViewController = RepositoryDetailsViewController(repository: state.items[indexPath.row])
        pushController?(repositoryDetailsViewController, true)
    }
    
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { state.items.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryCell = tableView.dequeueReusableCell(for: indexPath)
        repositoryPresenter.present(model: state.items[indexPath.row], for: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == state.items.count - 1 else { return }
        performEvent(.loadNextPage)
    }

}
