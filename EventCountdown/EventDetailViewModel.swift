import CoreData
import UIKit

final class EventDetailViewModel {
    private let eventID: NSManagedObjectID
    private let eventManager: EventManagerProtocol
    private var event: Event?
    private let date = Date()
    var onUpdate = {}
    
    var image: UIImage? {
        guard let imageData = event?.image else { return nil }
        return UIImage(data: imageData)
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event?.date,
              let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",")
        else { return nil}
        
        return TimeRemainingViewModel(timerRemainingParts: timeRemainingParts, mode: .detail)
    }
    
    var coordinator: EventDetailCoordinator?
    
    init(eventID: NSManagedObjectID, eventManager: EventManagerProtocol = EventManager()) {
        self.eventID = eventID
        self.eventManager = eventManager
    }
    
    func viewDidLoad() {
        reload()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    @objc func editButtonTapped() {
        guard let event = event else { return }
        coordinator?.onEditEvent(event: event)
    }
    
    func reload() {
        event = eventManager.getEvent(eventID)
        onUpdate()
    }
}
