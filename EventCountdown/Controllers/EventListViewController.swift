import UIKit

final class EventListViewController: UIViewController {
    var viewModel: EventListViewModel!
    
    lazy private var eventListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let coreDataManager = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()
        
        viewModel.onUpdate = { [weak self] in
            self?.eventListTableView.reloadData()
        }
        
        viewModel.viewDidLoad()
    }
}

extension EventListViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(tapAddEventButton))
        barButtonItem.tintColor = .lightPurple
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func tapAddEventButton() {
        viewModel.tappedAddEvent()
    }
    
    private func configureTableView() {
        view.addSubview(eventListTableView)
        NSLayoutConstraint.activate([
            eventListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            eventListTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            eventListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            eventListTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cell(at: indexPath) {
        case .event(let eventCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
            cell.update(with: eventCellViewModel)
            
            return cell
        }
    }
}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}
