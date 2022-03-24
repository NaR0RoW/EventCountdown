import UIKit

final class SettingsViewController: UIViewController, UIGestureRecognizerDelegate {
    var settingsViewModel: SettingsViewModel!
    
    lazy private var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(SettingsCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureSettingsTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        settingsViewModel.viewDidDisappear()
    }
}

extension SettingsViewController {
    private func configureView() {
        navigationItem.title = settingsViewModel.title
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        let imageIcon = UIImage(systemName: "xmark")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        let leftBarButtonItem = UIBarButtonItem(image: imageIcon, style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func configureSettingsTableView() {
        view.addSubview(settingsTableView)
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SettingsCell
    
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
