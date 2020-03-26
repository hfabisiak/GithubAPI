import UIKit

final class RepositoryDetailsView: UIView {
    
    //MARK: - Internal stored properties
    
    private(set) var detailsTableView = Subviews.detailsTableView
    
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
        addSubview(detailsTableView)
    }
    
    private func setupConstraints() {
        detailsTableView.snp.makeConstraints{
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }

}

extension RepositoryDetailsView {
    
    enum Subviews {
        
        static var detailsTableView: UITableView {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.allowsSelection = false
            tableView.register(cell: RepositoryDetailsCell.self)
            tableView.estimatedRowHeight = 50.0
            tableView.rowHeight = UITableView.automaticDimension
            return tableView
        }
        
    }
    
}
