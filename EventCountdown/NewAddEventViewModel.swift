import Foundation

final class NewAddEventViewModel {
    let title = "Add event"
    
    var coordinator: NewAddEventCoordinator?
    
    func tappedStartAddDate() {
        coordinator?.startAddDate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}
