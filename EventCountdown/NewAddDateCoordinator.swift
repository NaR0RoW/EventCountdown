import UIKit

final class NewAddDateCoordinator: CoordinatorProtocol {
    private(set) var childCoordinators: [CoordinatorProtocol] = []
    private let navigationController: UINavigationController
    var parentCoordinator: CoordinatorProtocol?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let newAddDateViewController = NewAddDateViewController()
        let newAddDateViewModel = NewAddDateViewModel()
        newAddDateViewModel.coordinator = self
        newAddDateViewController.newAddDateViewModel = newAddDateViewModel
        navigationController.pushViewController(newAddDateViewController, animated: true)
    }

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }

    func childDidFinish(_ childCoordinator: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
