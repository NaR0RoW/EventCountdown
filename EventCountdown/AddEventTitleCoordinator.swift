import UIKit

final class AddEventTitleCoordinator: CoordinatorProtocol {
    private(set) var childCoordinators: [CoordinatorProtocol] = []
    private let navigationController: UINavigationController
    var parentCoordinator: CoordinatorProtocol?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let addEventTitleViewController = AddEventTitleViewController()
        let addEventTitleViewModel = AddEventTitleViewModel()
        addEventTitleViewModel.coordinator = self
        addEventTitleViewController.addEventTitleViewModel = addEventTitleViewModel
        navigationController.pushViewController(addEventTitleViewController, animated: true)
    }
    
    func startAddDate() {
        let addDateCoordinator = AddEventDateCoordinator(navigationController: navigationController)
        addDateCoordinator.parentCoordinator = self
        childCoordinators.append(addDateCoordinator)
        addDateCoordinator.start()
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
