import UIKit

extension UITableView {
    
    func register<Cell: UITableViewCell>(cell: Cell.Type) {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell for indexPath: \(indexPath)")
        }
        return cell
    }
    
    func deselectSelectedRow() {
        guard let selectedIndexPath = indexPathForSelectedRow else { return }
        deselectRow(at: selectedIndexPath, animated: true)
    }
}

