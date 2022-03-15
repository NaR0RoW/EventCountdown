import UIKit

final class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel!
    
    private let coreDataManager = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
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
}
