import UIKit

final class EventCell: UITableViewCell {
    private let timeRemainingLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    private let dateLabel = UILabel()
    private let eventNameLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let verticalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventCell {
    private func configureViews() {
        (timeRemainingLabels + [dateLabel, eventNameLabel, backgroundImageView, verticalStackView]).forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        timeRemainingLabels.forEach {
            $0.font = .systemFont(ofSize: 28.0 , weight: .medium)
            $0.textColor = .white
        }
        
        [dateLabel, eventNameLabel].forEach {
            $0.textColor = .white
        }
        
        dateLabel.font = .systemFont(ofSize: 22.0, weight: .medium)
        eventNameLabel.font = .systemFont(ofSize: 34.0, weight: .bold)
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
    }
    
    private func configureConstraints() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)
        
        verticalStackView.addArrangedSubviews(timeRemainingLabels + [UIView(), dateLabel])
        
        backgroundImageView.pinToSuperviewEdges([.left, .top, .right, .bottom])
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        
        backgroundImageView.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        verticalStackView.pinToSuperviewEdges([.top, .right, .bottom], constant: 15.0)
        eventNameLabel.pinToSuperviewEdges([.left, .bottom], constant: 15.0)
    }
    
    func update(with viewModel: EventCellViewModel) {
        viewModel.timeRemainingStrings.enumerated().forEach {
            timeRemainingLabels[$0.offset].text = $0.element
        }
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        
        viewModel.loadImage { image in
            self.backgroundImageView.image = image
        }
    }
}
