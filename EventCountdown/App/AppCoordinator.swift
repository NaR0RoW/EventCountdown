import UIKit

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get }
    func start()
    func childDidFinish(_ childCoordinator: CoordinatorProtocol)
}

protocol EventUpdatingCoordinator {
    var onUpdateEvent: (() -> Void)? { get }
}

extension CoordinatorProtocol {
    func childDidFinish(_ childCoordinator: CoordinatorProtocol) { }
}

final class AppCoordinator: CoordinatorProtocol {
    private(set) var childCoordinators: [CoordinatorProtocol] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        
        let eventListCoordinator = EventListCoordinator(navigationController: navigationController)

        childCoordinators.append(eventListCoordinator)

        eventListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
