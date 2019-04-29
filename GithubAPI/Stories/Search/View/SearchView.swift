//
//  SearchView.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    private(set) var resultsTableView = Subviews.resultsTableView
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(resultsTableView)
    }
    
    private func setupConstraints() {
        resultsTableView.snp.makeConstraints{
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    required init?(coder _: NSCoder) { return nil }
}

extension SearchView {
    
    enum Subviews {
        
        static var resultsTableView: UITableView {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.rowHeight = 75.0
            tableView.register(cell: RepositoryCell.self)
            return tableView
        }
        
    }
    
    
}
