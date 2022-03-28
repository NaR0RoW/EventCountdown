import Foundation

final class NewAddDateViewModel {
    let title = "Add date"
    
    var coordinator: NewAddDateCoordinator?
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}
