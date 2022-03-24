import UIKit

final class EventListViewController: UIViewController {
    var eventListViewModel: EventListViewModel!
    
    lazy private var eventListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()
        
        eventListViewModel.onUpdate = { [weak self] in
            self?.eventListTableView.reloadData()
        }
        
        eventListViewModel.viewDidLoad()
    }
}

extension EventListViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = eventListViewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(tapAddEventButton))
        barButtonItem.tintColor = .lightPurple
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func tapAddEventButton() {
        eventListViewModel.tappedAddEvent()
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
        return eventListViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch eventListViewModel.cell(at: indexPath) {
        case .event(let eventCellViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
                return UITableViewCell()
            }
            cell.update(with: eventCellViewModel)
            
            return cell
        }
    }
}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventListViewModel.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}
