import UIKit

final class SwitchCell: UITableViewCell {
    private let switchCellLabel: UILabel = {
        let label = UILabel()
        label.text = "All Day"
        label.font = .systemFont(ofSize: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let switchCellSwitch: UISwitch = {
        let commonSwitch = UISwitch()
        commonSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        return commonSwitch
    }()

    
    func configureCell() {
        configureView()
    }
}

extension SwitchCell {
    private func configureView() {
        addSubview(switchCellLabel)
        NSLayoutConstraint.activate([
            switchCellLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchCellLabel.leftAnchor.constraint(equalTo: leftAnchor)
        ])
        
        addSubview(switchCellSwitch)
        NSLayoutConstraint.activate([
            switchCellSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchCellSwitch.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
