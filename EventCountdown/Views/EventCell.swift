import UIKit

final class EventCell: UITableViewCell {
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28.0, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28.0, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let weekLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28.0, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let daysLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28.0, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22.0, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34.0, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventCell {
    private func configureView() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)
        
        verticalStackView.addArrangedSubview(yearLabel)
        verticalStackView.addArrangedSubview(monthLabel)
        verticalStackView.addArrangedSubview(weekLabel)
        verticalStackView.addArrangedSubview(daysLabel)
        verticalStackView.addArrangedSubview(UIView())
        verticalStackView.addArrangedSubview(dateLabel)
        
        backgroundImageView.pinToSuperviewEdges([.left, .top, .right, .bottom])
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        
        backgroundImageView.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        verticalStackView.pinToSuperviewEdges([.top, .right, .bottom], constant: 15.0)
        eventNameLabel.pinToSuperviewEdges([.left, .bottom], constant: 15.0)
    }
    
    func update(with viewModel: EventCellViewModel) {
        yearLabel.text = viewModel.yearText
        monthLabel.text = viewModel.monthText
        weekLabel.text = viewModel.weekText
        daysLabel.text = viewModel.dayText
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        backgroundImageView.image = viewModel.backgroundImage
    }
}
