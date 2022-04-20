import UIKit

final class DateCell: UITableViewCell {
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .black)
        label.textColor = .white
        label.text = "7 April 2022"
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 10.0
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func configureCell() {
        configureView()
    }
}

extension DateCell {
    private func configureView() {
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }
}
