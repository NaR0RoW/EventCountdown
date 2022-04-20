import UIKit

final class AddEventDateCoordinator: CoordinatorProtocol {
    private(set) var childCoordinators: [CoordinatorProtocol] = []
    private let navigationController: UINavigationController
    var parentCoordinator: CoordinatorProtocol?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let addEventDateViewController = AddEventDateViewController()
        let addEventDateViewModel = AddEventDateViewModel()
        addEventDateViewModel.coordinator = self
        addEventDateViewController.addEventDateViewModel = addEventDateViewModel
        navigationController.pushViewController(addEventDateViewController, animated: true)
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
