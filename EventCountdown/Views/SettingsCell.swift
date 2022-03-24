import UIKit

final class SettingsCell: UITableViewCell {
    private let settingsNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = .label
        label.text = "Test"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let settingsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
            settingsImageView.widthAnchor.constraint(equalToConstant: contentView.frame.height),
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
}
