import UIKit

final class AddEventDateViewController: UIViewController {
    var addEventDateViewModel: AddEventDateViewModel!
    private var factory: FactoryProtocol?
    
    private let dateTableView: UITableView = {
        let tableView = UITableView()
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.showsVerticalScrollIndicator = false
//        tableView.allowsSelection = false
//        tableView.bounces = false
//        tableView.separatorStyle = .none
//        tableView.contentInsetAdjustmentBehavior = .never
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
        let tableViewDataSource = TableViewDataSource()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.success(with: tableViewDataSource)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addEventDateViewModel.viewDidDisappear()
    }
}

extension AddEventDateViewController {
    private func configureView() {
//        view.backgroundColor = .systemBackground
        navigationItem.title = addEventDateViewModel.title

        hideNavigationBarGrayBottomLine()
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(tapDismiss))
        leftBarButtonItem.tintColor = .label
        
        let rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(tapNext))
        rightBarButtonItem.tintColor = .label
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func configureTableView() {
        view.addSubview(dateTableView)
//        dateTableView.backgroundColor = .red
        NSLayoutConstraint.activate([
            dateTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            dateTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dateTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    @objc private func tapDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapNext() {
        print("Tapped next")
    }
}

extension AddEventDateViewController {
    func success(with dataSource: TableViewDataSourceProtocol?) {
        dateTableView.delegate = dataSource
        dateTableView.dataSource = dataSource
    
        factory = TableViewFactory(tableView: dateTableView)
        if let sections = factory?.getSections() {
            dataSource?.sections = sections
        }
        
        self.dateTableView.reloadData()
    }
}
