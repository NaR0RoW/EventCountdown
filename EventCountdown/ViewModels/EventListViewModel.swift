import Foundation

final class EventListViewModel {
    let title = "Events"
    var coordinator: EventListCoordinator?
    var onUpdate = { }
    
    enum Cell {
        case event(EventCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    
    private let coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func viewDidLoad() {
        reload()
    }
    
    func reload() {
        let events = coreDataManager.fetchEvent()
        cells = events.map {
            .event(EventCellViewModel($0))
        }
        onUpdate()
    }
}
