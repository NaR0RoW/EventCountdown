import Foundation

final class EventListViewModel {
    let title: String = "Upcoming Events"
    var coordinator: EventListCoordinator?
    var onUpdate = { }
    
    enum Cell {
        case event(EventCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    
    private let eventManager: EventManagerProtocol

    init(eventManager: EventManagerProtocol = EventManager()) {
        self.eventManager = eventManager
    }
    
    func tappedOldAddEvent() {
        coordinator?.startOldAddEvent()
    }
    
    func tappedSettings() {
        coordinator?.startSettings()
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
        EventCellViewModel.imageCache.removeAllObjects()
        let events = eventManager.getEvents()
        cells = events.map {
            var eventCellViewModel = EventCellViewModel($0)
            if let coordinator = coordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }
            return .event(eventCellViewModel)
        }
        onUpdate()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
}
