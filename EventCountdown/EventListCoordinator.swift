import CoreData
import UIKit

final class EventListCoordinator: CoordinatorProtocol & EventUpdatingCoordinator {
    private(set) var childCoordinators: [CoordinatorProtocol] = []
    private let navigationController: UINavigationController
    var onUpdateEvent: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListViewController = EventListViewController()
        let eventListViewModel = EventListViewModel()
        eventListViewController.eventListViewModel = eventListViewModel
        eventListViewModel.coordinator = self
        onUpdateEvent = eventListViewModel.reload
   
        navigationController.setViewControllers([eventListViewController], animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func onSelect(_ id: NSManagedObjectID) {
        let eventDetailCoordinator = EventDetailCoordinator(navigationController: navigationController, eventID: id)
        eventDetailCoordinator.parentCoordinator = self
        childCoordinators.append(eventDetailCoordinator)
        eventDetailCoordinator.start()
    }
    
    func startSettings() {
        let settingsCoordinator = SettingsCoordinator(navigationController: navigationController)
        settingsCoordinator.parentCoordinator = self
        childCoordinators.append(settingsCoordinator)
        settingsCoordinator.start()
    }
    
    func startAddNewEvent() {
        let newAddEventCoordinator = NewAddEventCoordinator(navigationController: navigationController)
        newAddEventCoordinator.parentCoordinator = self
        childCoordinators.append(newAddEventCoordinator)
        newAddEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}