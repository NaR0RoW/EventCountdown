import UIKit

final class CommonCell: UITableViewCell {
    private let commonCellLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22.0)
        label.numberOfLines = 0
        label.text = "Default"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let commonCellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    func configureCell() {
       
        configureView()
    }
}

extension CommonCell {
    private func configureView() {
        addSubview(commonCellLabel)
        NSLayoutConstraint.activate([
            commonCellLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            commonCellLabel.leftAnchor.constraint(equalTo: leftAnchor)
        ])
        
        addSubview(commonCellImageView)
        NSLayoutConstraint.activate([
            commonCellLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            commonCellLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
