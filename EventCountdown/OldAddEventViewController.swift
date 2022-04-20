import UIKit

final class OldAddEventViewController: UIViewController {
    var addEventViewModel: OldAddEventViewModel!
    
    private let addEventTableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(TitleSubtitleCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureAddEventTableView()
        
        addEventViewModel.onUpdate = { [weak self] in
            self?.addEventTableView.reloadData()
        }
        
        addEventViewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        addEventViewModel.viewDidDisappear()
    }
}

extension OldAddEventViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = addEventViewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureAddEventTableView() {
        view.addSubview(addEventTableView)
        addEventTableView.dataSource = self
        addEventTableView.delegate = self
        NSLayoutConstraint.activate([
            addEventTableView.topAnchor.constraint(equalTo: view.topAnchor),
            addEventTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            addEventTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addEventTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        addEventTableView.tableFooterView = UIView()
        addEventTableView.setContentOffset(.init(x: 0.0, y: -1.0), animated: false)
    }
    
    @objc private func tappedDone() {
        addEventViewModel.tappedDone()
    }
}

extension OldAddEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addEventViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = addEventViewModel.cell(for: indexPath)
        
        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TitleSubtitleCell
            cell.update(with: titleSubtitleCellViewModel)
            cell.subtitleTextFiled.delegate = self
            
            return cell
        }
    }
}

extension OldAddEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addEventViewModel.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension OldAddEventViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string
        
        let point = textField.convert(textField.bounds.origin, to: addEventTableView)
        if let indexPath = addEventTableView.indexPathForRow(at: point) {
            addEventViewModel.updateCell(indexPath: indexPath, subtitle: text)
        }
        
        return true
    }
}
