import UIKit

final class EventCell: UITableViewCell {
    private let timeRemainingStackView: TimeRemainingStackView = {
        let stackView = TimeRemainingStackView()
        
        return stackView
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
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
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
        
        timeRemainingStackView.setup()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventCell {
    private func configureView() {
        selectionStyle = .none
        
        configureBackgroundImageView()
        configureVerticalStackView()
        configureEventNameLabel()
    }
    
    private func configureBackgroundImageView() {
        contentView.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15.0),
            backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15.0),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15.0),
            backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0)
        ])
    }
    
    private func configureVerticalStackView() {
        backgroundImageView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubviews([timeRemainingStackView, UIView(), dateLabel])
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 15.0),
            verticalStackView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -15.0),
            verticalStackView.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor, constant: -15.0)
        ])
    }
    
    private func configureEventNameLabel() {
        backgroundImageView.addSubview(eventNameLabel)
        NSLayoutConstraint.activate([
            eventNameLabel.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor, constant: 15.0),
            eventNameLabel.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -15.0)
        ])
    }
    
    func update(with viewModel: EventCellViewModel) {
        if let timeRemainingViewModel = viewModel.timeRemainingViewModel {
            timeRemainingStackView.update(with: timeRemainingViewModel)
        }
       
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        
        viewModel.loadImage { image in
            self.backgroundImageView.image = image
        }
    }
}
