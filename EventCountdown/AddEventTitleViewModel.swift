import Foundation

final class AddEventTitleViewModel {
    let title = "Add event"
    
    var coordinator: AddEventTitleCoordinator?
    
    func tappedStartAddDate() {
        coordinator?.startAddDate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}
