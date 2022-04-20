import UIKit

final class EventListViewController: UIViewController {
    var eventListViewModel: EventListViewModel!
    
    private let eventListTableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(EventCell.self)
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

       hideNavigationBarGrayBottomLine()
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tapAddEventButton))
        rightBarButtonItem.tintColor = .label
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(tapSettingsButton))
        leftBarButtonItem.tintColor = .label
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc private func tapAddEventButton() {
        // Old version
//        eventListViewModel.tappedAddEvent()
        
        // New version
        eventListViewModel.tappedAddEvent()
    }
    
    @objc private func tapSettingsButton() {
        eventListViewModel.tappedSettings()
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
        
//        print("Ye")
//        print(eventListTableView.frame)
//        print(eventListTableView.bounds)
//        let a = eventListTableView.bounds
        
//        Ye
//        (0.0, 0.0, 0.0, 0.0)
//        (0.0, -91.0, 0.0, 0.0)
//        Ye
//        (0.0, 0.0, 428.0, 926.0)
//        (0.0, -91.0, 428.0, 926.0)
        
//        Ye
//        (0.0, 0.0, 428.0, 926.0)
//        (0.0, 355.0, 428.0, 926.0)
//        Ye
//        (0.0, 0.0, 926.0, 428.0)
//        (0.0, 308.0, 926.0, 428.0)

//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("eventListTableView Frame: ", eventListTableView.frame)
        print("eventListTableView Bounds: ", eventListTableView.bounds)
        print("view frame", view.frame)
        print("view bounds", view.bounds)
    }
    
    private func configureTableView() {
        view.addSubview(eventListTableView)
        eventListTableView.dataSource = self
        eventListTableView.delegate = self
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
        eventListViewModel.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
}
