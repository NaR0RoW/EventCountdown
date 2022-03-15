import UIKit

final class EventListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
}

extension EventListViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let item = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(tapItem))
        item.tintColor = .lightPurple
        navigationItem.rightBarButtonItem = item
    }
    
    @objc private func tapItem() {
        print("Tapped")
    }
}
