import UIKit

final class NewAddEventCoordinator: CoordinatorProtocol {
    private(set) var childCoordinators: [CoordinatorProtocol] = []
    private let navigationController: UINavigationController
    var parentCoordinator: CoordinatorProtocol?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let newAddEventViewController = NewAddEventViewController()
        let newAddEventViewModel = NewAddEventViewModel()
        newAddEventViewModel.coordinator = self
        newAddEventViewController.newAddEventViewModel = newAddEventViewModel
        navigationController.pushViewController(newAddEventViewController, animated: true)
    }
    
    func startAddDate() {
        let newAddDateCoordinator = NewAddDateCoordinator(navigationController: navigationController)
        newAddDateCoordinator.parentCoordinator = self
        childCoordinators.append(newAddDateCoordinator)
        newAddDateCoordinator.start()
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
