//
//  RepositoryCell.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    private(set) var avatarImageView = Subviews.avatarImageView
    private(set) var topLabel = Subviews.topLabel
    private(set) var bottomLabel = Subviews.bottomLabel
    
    private let textStackView = Subviews.textStackView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [topLabel, bottomLabel].forEach(textStackView.addArrangedSubview)
        [avatarImageView, textStackView].forEach(contentView.addSubview)
    }
    
    private func setupConstraints() {
        avatarImageView.snp.makeConstraints{
            $0.size.equalTo(40.0)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        textStackView.snp.makeConstraints{
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(4.0)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    required init?(coder _: NSCoder) { return nil }
}

extension RepositoryCell {
    
    enum Subviews {
        
        static var avatarImageView: UIImageView {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
        
        static var textStackView: UIStackView {
            let stackView = UIStackView()
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 2.0
            stackView.axis = .vertical
            return stackView
        }
        
        static var topLabel: UILabel {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
            label.lineBreakMode = .byTruncatingTail
            return label
        }
        
        static var bottomLabel: UILabel {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.systemFont(ofSize: 10.0, weight: .regular)
            label.textColor = UIColor.lightGray
            label.lineBreakMode = .byTruncatingTail
            return label
        }
        
    }
    
}

