import Foundation

final class AddEventDateViewModel {
    let title = "Add date"
    
    var coordinator: AddEventDateCoordinator?
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}
