import UIKit

final class EventListViewController: UIViewController {
    var eventListViewModel: EventListViewModel!
    
    lazy private var eventListTableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(EventCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
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
        navigationItem.title = eventListViewModel.title

        // To hide UINavigationBar gray bottom line
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tapAddEventButton))
        rightBarButtonItem.tintColor = .label
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(tapSettingsButton))
        leftBarButtonItem.tintColor = .label
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc private func tapAddEventButton() {
        eventListViewModel.tappedAddEvent()
    }
    
    @objc private func tapSettingsButton() {
        eventListViewModel.tappedSettings()
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
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EventCell
            cell.update(with: eventCellViewModel)
            
            return cell
        }
    }
}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        eventListViewModel.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
}
