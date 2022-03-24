import UIKit

final class SettingsCoordinator: CoordinatorProtocol & EventUpdatingCoordinator {
    private(set) var childCoordinators: [CoordinatorProtocol] = []
    private let navigationController: UINavigationController
    var onUpdateEvent: (() -> Void)?
    var parentCoordinator: (EventUpdatingCoordinator & CoordinatorProtocol)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let settingsViewController = SettingsViewController()
        let settingsViewModel = SettingsViewModel()
        settingsViewModel.coordinator = self
        settingsViewController.settingsViewModel = settingsViewModel
        navigationController.pushViewController(settingsViewController, animated: true)
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
