//
//  UITableView+Extensions.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

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
    
}

