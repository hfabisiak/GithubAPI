//
//  RepositoryDetailsCell.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import UIKit

class RepositoryDetailsCell: UITableViewCell {
    
    private(set) var titleLabel = Subviews.titleLabel
    private(set) var detailsLabel = Subviews.detailsLabel
    private let textStackView = Subviews.textStackView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [titleLabel, detailsLabel].forEach(textStackView.addArrangedSubview)
        contentView.addSubview(textStackView)
    }
    
    private func setupConstraints() {
        textStackView.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().offset(-16.0)
            $0.top.leading.equalToSuperview().offset(16.0)
        }
    }
    
    required init?(coder _: NSCoder) { return nil }
}

extension RepositoryDetailsCell {
    
    enum Subviews {
        
        static var titleLabel: UILabel {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
            label.textColor = ColorsPalette.black
            return label
        }
        
        static var detailsLabel: UILabel {
            let label = UILabel()
            label.textAlignment = .right
            label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
            label.textColor = ColorsPalette.blueGrey
            label.numberOfLines = 0
            return label
        }
        
        static var textStackView: UIStackView {
            let stackView = UIStackView()
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 2.0
            stackView.axis = .horizontal
            return stackView
        }
        
    }
    
}
