import UIKit

final class RepositoryCell: UITableViewCell {
    
    //MARK: - Internal stored properties
    
    private(set) var avatarImageView = Subviews.avatarImageView
    private(set) var topLabel = Subviews.topLabel
    private(set) var bottomLabel = Subviews.bottomLabel
    
    //MARK: - Private stored properties
    
    private let textStackView = Subviews.textStackView
    private let wholeViewStackView = Subviews.wholeViewStackView
    
    //MARK: - Internal methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) { nil }
    
    //MARK: - Private methods
    
    private func addSubviews() {
        addSubview(wholeViewStackView)
        [topLabel, bottomLabel].forEach(textStackView.addArrangedSubview)
        [avatarImageView, textStackView].forEach(wholeViewStackView.addArrangedSubview)
    }
    
    private func setupConstraints() {
        wholeViewStackView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(16.0)
        }
        
        avatarImageView.snp.makeConstraints{
            $0.size.equalTo(40.0)
        }
    }
    
}

extension RepositoryCell {
    
    enum Subviews {
        
        static var avatarImageView: UIImageView {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "github_base_avatar")
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
            label.numberOfLines = 0
            return label
        }
        
        static var wholeViewStackView: UIStackView {
            let stackView = UIStackView()
            stackView.distribution = .fill
            stackView.alignment = .center
            stackView.spacing = 6.0
            stackView.axis = .horizontal
            return stackView
        }
        
    }
    
}

