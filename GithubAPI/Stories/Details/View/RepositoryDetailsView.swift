//
//  RepositoryDetailsView.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import UIKit

class RepositoryDetailsView: UIView {
    
    private(set) var detailsTableView = Subviews.detailsTableView
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(detailsTableView)
    }
    
    private func setupConstraints() {
        detailsTableView.snp.makeConstraints{
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    required init?(coder _: NSCoder) { return nil }
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
