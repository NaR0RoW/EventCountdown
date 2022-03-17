import UIKit

final class TitleSubtitleCell: UITableViewCell {
    private var viewModel: TitleSubtitleCellViewModel?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22.0, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let subtitleTextFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.font = .systemFont(ofSize: 20.0, weight: .medium)
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        
        return textFiled
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let toolbar: UIToolbar = UIToolbar(frame: .init(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    
    private let datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black.withAlphaComponent(0.4)
        imageView.layer.cornerRadius = 10.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureVerticalStackView()
        configureToolbar()
        configurePhotoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        subtitleTextFiled.text = viewModel.subtitle
        subtitleTextFiled.placeholder = viewModel.placeholder
        
        subtitleTextFiled.inputView = viewModel.type == .text ? nil : datePickerView
        subtitleTextFiled.inputAccessoryView = viewModel.type == .text ? nil : toolbar
        
        photoImageView.isHidden = viewModel.type != .image
        subtitleTextFiled.isHidden = viewModel.type == .image
        
        verticalStackView.spacing = viewModel.type == .image ? 15.0 : verticalStackView.spacing
    }
    
    private func configureVerticalStackView() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextFiled)
        verticalStackView.addArrangedSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15.0),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0)
        ])
    }
    
    private func configurePhotoImageView() {
        photoImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
    }
    
    private func configureToolbar() {
        toolbar.setItems([doneButton], animated: false)
    }
    
    @objc private func tappedDone() {
        viewModel?.update(datePickerView.date)
    }
}
