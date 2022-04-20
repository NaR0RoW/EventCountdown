import UIKit

final class EditEventViewController: UIViewController {
    var editEventViewModel: EditEventViewModel!
    
    private let editEventTableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(TitleSubtitleCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureEditEventTableView()
        
        editEventViewModel.onUpdate = { [weak self] in
            self?.editEventTableView.reloadData()
        }
        
        editEventViewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        editEventViewModel.viewDidDisappear()
    }
}

extension EditEventViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = editEventViewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureEditEventTableView() {
        view.addSubview(editEventTableView)
        editEventTableView.delegate = self
        editEventTableView.dataSource = self
        NSLayoutConstraint.activate([
            editEventTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editEventTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            editEventTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            editEventTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        editEventTableView.tableFooterView = UIView()
        editEventTableView.setContentOffset(.init(x: 0.0, y: -1.0), animated: false)
    }
    
    @objc private func tappedDone() {
        editEventViewModel.tappedDone()
    }
}

extension EditEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editEventViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = editEventViewModel.cell(for: indexPath)
        
        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TitleSubtitleCell
            cell.update(with: titleSubtitleCellViewModel)
            cell.subtitleTextFiled.delegate = self
            
            return cell
        }
    }
}

extension EditEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editEventViewModel.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension EditEventViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string
        
        let point = textField.convert(textField.bounds.origin, to: editEventTableView)
        if let indexPath = editEventTableView.indexPathForRow(at: point) {
            editEventViewModel.updateCell(indexPath: indexPath, subtitle: text)
        }
        
        return true
    }
}
