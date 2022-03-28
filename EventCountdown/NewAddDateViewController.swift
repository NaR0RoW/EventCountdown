import UIKit

final class NewAddDateViewController: UIViewController {
    var newAddDateViewModel: NewAddDateViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        newAddDateViewModel.viewDidDisappear()
    }
}

extension NewAddDateViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = newAddDateViewModel.title

        hideNavigationBarGrayBottomLine()
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(tapDismiss))
        leftBarButtonItem.tintColor = .label
        
        let rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(tapNext))
        rightBarButtonItem.tintColor = .label
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc private func tapDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapNext() {
        print("Tapped next")
    }
}
