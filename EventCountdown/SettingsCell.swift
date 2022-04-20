import UIKit

final class SettingsCell: UITableViewCell {
    private let settingsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let settingsNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22.0)
        label.textColor = .label
        label.text = "Test"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureSettingsImageView()
        configureSettingsNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsCell {
    private func configureSettingsImageView() {
        contentView.addSubview(settingsImageView)
        NSLayoutConstraint.activate([
            settingsImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15.0),
            settingsImageView.widthAnchor.constraint(equalToConstant: contentView.frame.height / 1.5),
            settingsImageView.heightAnchor.constraint(equalTo: settingsImageView.widthAnchor)
        ])
    }
    
    private func configureSettingsNameLabel() {
        contentView.addSubview(settingsNameLabel)
        NSLayoutConstraint.activate([
            settingsNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsNameLabel.leftAnchor.constraint(equalTo: settingsImageView.rightAnchor, constant: 20.0)
        ])
    }
    
    func configure(with viewModel: SettingsViewModel, for indexPath: IndexPath) {
        settingsImageView.image = viewModel.cell(at: indexPath).image
        settingsNameLabel.text = viewModel.cell(at: indexPath).name
    }
}
