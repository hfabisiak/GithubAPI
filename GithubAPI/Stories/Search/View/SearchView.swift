import UIKit
import SnapKit

final class SearchView: UIView {
    
    //MARK: - Internal stored properties
    
    private(set) var resultsTableView = Subviews.resultsTableView
    
    //MARK: - Internal methods
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) { nil }
    
    //MARK: - Private methods
    
    private func addSubviews() {
        addSubview(resultsTableView)
    }
    
    private func setupConstraints() {
        resultsTableView.snp.makeConstraints{
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }

}

extension SearchView {
    
    enum Subviews {
        
        static var resultsTableView: UITableView {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.keyboardDismissMode = .onDrag
            tableView.estimatedRowHeight = 75.0
            tableView.register(cell: RepositoryCell.self)
            tableView.contentInsetAdjustmentBehavior = .never
            return tableView
        }
        
    }
    
    
}
